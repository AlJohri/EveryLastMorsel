class PostsController < InheritedResources::Base

  layout lambda { |placeholder| params[:user_id] ? "posts" : "application" }

  respond_to :html, :xml, :json
  belongs_to :user, :optional => true

  # include ::ActionView::Helpers::TextHelper

  def index
    super do |format|
      format.html { render "feed-index.slim" if !params[:user_id] }
      format.json { render :json => @posts }
    end
  end

  def like
    @post = Post.find(params[:id])
    @ret = ""
    if user_signed_in?
      if current_user.flag(@post, :dig) then
        @ret = pluralize(@post.flaggings.count, 'person digs', 'people dig') + ' it. Un-dig?';
      else
        current_user.unflag(@post, :dig)
        @ret = 'Dig it? ' + pluralize(@post.flaggings.count, 'person digs it.', 'people dig it');
      end
    else
      redirect_to posts_path, :alert => "Please create an account!"
    end
    
    # format.html { redirect_to user_post_path(@post.user, @post), :notice => ret }

    respond_to do |format|
      format.json { render :json => @ret }
      format.js { render :layout => ! request.xhr? }
    end

  end

end