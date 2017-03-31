class BlogPostsController < ApplicationController

  def index
    @blog_posts = BlogPost.approved.published

    if params[:id].blank? && @blog_posts.first.present?
      redirect_to blog_post_path(@blog_posts.first)
    else
      @current_post = BlogPost.friendly.find(params[:id])
    end

    @comment = PostComment.new(user: User.new)
  end

  def new
    @blog_post = BlogPost.new(asked_by: User.new)
  end

  def create
    @blog_post = BlogPost.new(blog_post_params.except(:user))
    @blog_post.posted_at = Time.now
    @blog_post.asked_by = current_user || create_signin_user(blog_post_params[:user], optional: true)

    if @blog_post.save
      redirect_to blog_post_path(@blog_post)
    else
      render :new
    end
  end

  def comments
    @comment = PostComment.new(post_comment_params)
    @comment.blog_post = BlogPost.friendly.find(params[:blog_post_id])
    @comment.user = current_user || create_signin_user(post_comment_params[:user], optional: false)

    if @comment.save
      redirect_to blog_post_path(@comment.blog_post)
    else
      render :index, anchor: 'comment_form'
    end
  end


private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body, user: [:name, :email, :password])
  end

  def post_comment_params
    params.require(:post_comment).permit(:text, user: [:name, :email, :password])
  end

  def create_signin_user(user_params, optional:)
    user_opted_not_to_signup = optional && user_params&.values&.all?(&:blank?)
    return if user_opted_not_to_signup

    user = User.find_or_create_by(user_params)
    return user if user.errors.any?

    sign_in(user)
    user
  end

end
