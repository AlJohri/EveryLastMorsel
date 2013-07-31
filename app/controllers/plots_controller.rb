class PlotsController < InheritedResources::Base

  layout lambda { |placeholder| params[:plot_id] || params[:id] ? "profile/plot-profile" : params[:user_id] ? "profile/user-profile" : "application" }

  respond_to :html, :xml, :json
  belongs_to :user, :optional => true

  def show
    if params[:plot_id]
      @plot = Plot.find(params[:plot_id])
    elsif params[:id]
      @plot = Plot.find(params[:id])
    end
  end

end