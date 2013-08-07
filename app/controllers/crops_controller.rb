class CropsController < InheritedResources::Base
	layout "generic"
	has_scope :page, :default => 1
  respond_to :html, :xml, :json

  def index
    # @crops = Crop.order(:name).where("name ILIKE ?", "%#{params[:term]}%").map(&:name)
    @crops = Crop.search(:name_start => params[:term]).result.map(&:name)
    super do |format|
      format.json { render :json => @crops }
      format.xml { render :xml => @crops}
    end
  end

end
