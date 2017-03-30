class Admin::BlogPostsController < AdminController
    before_action :set_blog_post, only: [:edit, :update, :destroy, :approve]

    def index
      @blog_posts = BlogPost.all
    end

    def new
      @blog_post = BlogPost.new
    end

    def edit
    end

    def create
      @blog_post = BlogPost.new(blog_post_params)
      @blog_post.approve
      @blog_post.posted_at = Time.now

      if @blog_post.save
        redirect_to admin_blog_posts_url, notice: 'BlogPost was successfully created.'
      else
        render :new
      end
    end

    def update
      if @blog_post.update(blog_post_params)
        redirect_to admin_blog_posts_url, notice: 'BlogPost was successfully updated.'
      else
        render :edit
      end
    end

    def approve
      @blog_post.approve!
      redirect_to admin_blog_posts_url
    end

    def destroy
      @blog_post.destroy
      redirect_to admin_blog_posts_url, notice: 'BlogPost was successfully destroyed.'
    end

  private

    def set_blog_post
      @blog_post = BlogPost.friendly.find(params[:id] || params[:blog_post_id])
    end

    def blog_post_params
      params.require(:blog_post).permit(:title, :body, :posted_at)
    end

end
