class PostsController < InheritedResources::Base

  layout lambda { |controller| params[:user_id] ? "profile/user-profile" : "generic" }

  respond_to :html, :xml, :json
  belongs_to :user, :optional => true 

  has_scope :page, :default => 1

  def index
    super do |format|
      @posts = @posts.reorder('created_at DESC')
      format.json { render :json => @posts }
      format.xml { render :xml => @posts }
    end
  end

  def like
    @post = Post.find(params[:id])
    @ret = Hash.new
    @ret['heart'] = ''
    @ret['digs'] = ''

    if user_signed_in?
      if current_user.flag(@post, :dig) then
        @ret['heart'] = 'icon-heart'
        @ret['digs'] = @post.flaggings.count
      else
        current_user.unflag(@post, :dig)
        @ret['heart'] = 'icon-heart-empty'
        @ret['digs'] = @post.flaggings.count
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