class BlogPostsController < ApplicationController

  def index
    @blog_posts = BlogPost.approved.published

    if params[:id].blank? && @blog_posts.first.present?
      redirect_to blog_post_path(@blog_posts.first)
    else
      @current_post = BlogPost.friendly.find(params[:id])
    end
  end

  def new
    @blog_post = BlogPost.new(asked_by: User.new)
  end

  def create
    @blog_post = BlogPost.new(blog_post_params.except(:user))
    @blog_post.posted_at = Time.now

    if user_signed_in?
      @blog_post.asked_by = current_user
     elsif user_params&.values&.any?(&:present?)
      @blog_post.asked_by = User.find_or_create_by(user_params)
      sign_in(@blog_post.asked_by) if @blog_post.asked_by.errors.blank?
    end

    if @blog_post.save
      redirect_to blog_post_path(@blog_post)
    else
      render :new
    end
  end


private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body, user: [:name, :email, :password])
  end

  def user_params
    blog_post_params[:user]
  end

end
