class Blogit::Custom::PostsController < Blogit::PostsController
	layout "posts"

    def index
      @user = User.find(params[:user_id])
      respond_to do |format| # where(blogger_id: @user.id)
        format.xml {
          @posts = Blogit::Post.order('created_at DESC')
        }
        format.html {
          @posts = Blogit::Post.for_index(params[Kaminari.config.param_name])
        }
        format.rss {
          @posts = Blogit::Post.order('created_at DESC')
        }
      end
    end

    def show
      @post = Blogit::Post.find(params[:post_id])
      @user = User.find(@post.blogger_id)
    end

    def tagged
      @posts = Post.for_index(params[Kaminari.config.param_name]).tagged_with(params[:tag])
      render :index
    end

    def new
      @user = User.find(params[:user_id])
      @post = current_blogger.blog_posts.new(params[:post])
    end

    def edit
  	  @user = User.find(params[:user_id])
      @post = current_blogger.blog_posts.find(params[:post_id])
    end

    def create
      @post = current_blogger.blog_posts.new(params[:post])
      @user = User.find(current_blogger.id)
      if @post.save
        redirect_to main_app.user_post_url(@user.slug, @post.to_param), notice: t(:blog_post_was_successfully_created, scope: 'blogit.posts')
      else
        render action: "new"
      end
    end

    def update
      @post = current_blogger.blog_posts.find(params[:id])
      @user = User.find(current_blogger.id)
      if @post.update_attributes(params[:post])
        redirect_to @post, notice: t(:blog_post_was_successfully_updated, scope: 'blogit.posts')
      else
        render action: "edit"
      end
    end

    def destroy
      @post = current_blogger.blog_posts.find(params[:id])
      @user = User.find(current_blogger.id)
      @post.destroy
      redirect_to posts_url, notice: t(:blog_post_was_successfully_destroyed, scope: 'blogit.posts')
    end

end