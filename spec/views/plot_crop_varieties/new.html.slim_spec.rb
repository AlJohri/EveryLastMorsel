require 'spec_helper'

describe "plot_crop_varieties/new" do
  before(:each) do
    assign(:plot_crop_variety, stub_model(PlotCropVariety).as_new_record)
  end

  it "renders new plot_crop_variety form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", plot_crop_varieties_path, "post" do
    end
  end
end
