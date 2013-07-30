require 'spec_helper'

describe "plot_crop_varieties/edit" do
  before(:each) do
    @plot_crop_variety = assign(:plot_crop_variety, stub_model(PlotCropVariety))
  end

  it "renders the edit plot_crop_variety form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", plot_crop_variety_path(@plot_crop_variety), "post" do
    end
  end
end
