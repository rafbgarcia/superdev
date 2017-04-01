class BlogPostsController < ApplicationController
  before_action :set_current_post, only: [:show, :create, :comments, :index]

  def index
    redirect_to blog_post_path(@blog_posts.first)
  end

  def show
    @comment = Comment.new(user: User.new)
    render :index
  end

  def new
    @blog_post = BlogPost.new(user: User.new)
  end

  def create
    @blog_post = BlogPost.new(blog_post_params.except(:user))
    @blog_post.posted_at = Time.now
    @blog_post.user = current_user || create_signin_user(blog_post_params[:user])

    if @blog_post.save
      redirect_to blog_post_path(@blog_post)
    else
      render :new
    end
  end

  def comments
    @comment = Comment.new(comment_params.except(:user))
    @comment.commentable = BlogPost.friendly.find(params[:blog_post_id])
    @comment.user = current_user || create_signin_user(comment_params[:user])

    if @comment.save
      redirect_to blog_post_path(@comment.commentable, anchor: "")
    else
      render :index
    end
  end


private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body, user: [:name, :email, :password])
  end

  def comment_params
    params.require(:comment).permit(:text, user: [:name, :email, :password])
  end

  def create_signin_user(user_params)
    return if params[:receive_email] == '0'

    if params[:new_account] == '1'
      user = User.create(user_params)
    else
      user = User.where(email: user_params[:email]).first

      if !user || !user.valid_password?(user_params[:password])
        flash[:alert] = 'E-mail ou senha incorretos'
        return User.new
      end
    end

    sign_in(user) if user.errors.blank?
    user
  end

  def set_current_post
    @blog_posts = BlogPost.includes(comments: :user).approved.published

    post_id = params[:blog_post_id] || params[:id]
    @current_post = BlogPost.friendly.find(post_id) if post_id.present?
  end

end

