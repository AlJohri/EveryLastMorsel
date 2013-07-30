require 'spec_helper'

describe "plot_crop_varieties/index" do
  before(:each) do
    assign(:plot_crop_varieties, [
      stub_model(PlotCropVariety),
      stub_model(PlotCropVariety)
    ])
  end

  it "renders a list of plot_crop_varieties" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
