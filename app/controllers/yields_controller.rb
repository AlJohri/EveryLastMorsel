class YieldsController < InheritedResources::Base

  respond_to :html, :xml, :json
  belongs_to :plot_crop_variety, :optional => true

  def index
    super do |format|
      format.json { render :json => @yields }
    end
  end

end
