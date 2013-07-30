require 'spec_helper'

describe "plot_crop_varieties/show" do
  before(:each) do
    @plot_crop_variety = assign(:plot_crop_variety, stub_model(PlotCropVariety))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
