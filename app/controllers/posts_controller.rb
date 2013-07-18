class PostsController < ApplicationController

  # GET /posts
  # GET /posts.json
  # GET users/1/posts
  # GET users/1/posts.json
  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @posts = @user.posts

      respond_to do |format|
        format.html { render "user-index" }
        format.json { render :json => @posts }
      end
    else
      @posts = Post.all
      respond_to do |format|
        format.html { render "index", :layout => 'application'}
        format.json { render :json => @posts }
      end
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  # GET users/1/posts/1
  # GET users/1/posts/1.json
  def show
    if params[:user_id]
      @user = User.find(params[:user_id])
      @post = @user.posts.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render :json => @post }
      end
    else
      @post = Post.find(params[:id])
      respond_to do |format|
        format.html { render :layout => 'application'}
        format.json { render :json => @post }
      end
    end
  end

  # GET users/1/posts/new
  # GET users/1/posts/new.json
  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @post }
    end
  end

  # GET users/1/posts/1/edit
  def edit
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  # POST users/1/posts
  # POST users/1/posts.json
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to([@post.user, @post], :notice => 'Post was successfully created.') }
        format.json { render :json => @post, :status => :created, :location => [@post.user, @post] }
      else
        format.html { render :action => "new" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT users/1/posts/1
  # PUT users/1/posts/1.json
  def update
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to([@post.user, @post], :notice => 'Post was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE users/1/posts/1
  # DELETE users/1/posts/1.json
  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to user_posts_url(user) }
      format.json { head :ok }
    end
  end

  def like
    @post = Post.find(params[:id])
    if user_signed_in?
      current_user.flag(@post, :heart)
      redirect_to post_path(@post), :notice => "You just liked this post!"
    end
  end
end
