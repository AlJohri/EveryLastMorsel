class CropTypesController < InheritedResources::Base
	has_scope :page, :default => 1
  
  respond_to :html, :xml, :json

  def index
    @crops = CropType.search(:name_start => params[:term]).result.map(&:name)
    super do |format|
      format.json { render :json => @crops }
      format.xml { render :xml => @crops}
    end
  end

end