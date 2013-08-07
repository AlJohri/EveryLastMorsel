class CommentsController < InheritedResources::Base #ApplicationController
  belongs_to :post
  actions :index, :create, :update, :destroy
  respond_to :html, :xml, :json

  def create
    create! { user_post_path(@post.user, @post) }
  end

end