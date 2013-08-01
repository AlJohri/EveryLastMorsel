class CommentsController < InheritedResources::Base #ApplicationController
  belongs_to :post
  actions :create, :update, :destroy
  respond_to :html, :xml, :json

  def create
    create! { user_post_path(@post.user, @post) }
    # @post = Post.find(params[:post_id])
    # @comment = @post.comments.create(params[:comment])
    # redirect_to post_path(@post)
  end

end