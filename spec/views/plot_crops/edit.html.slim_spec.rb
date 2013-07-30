require 'spec_helper'

describe "plot_crops/edit" do
  before(:each) do
    @plot_crop = assign(:plot_crop, stub_model(PlotCrop,
      :coverage => "9.99",
      :coverage_type => "MyString"
    ))
  end

  it "renders the edit plot_crop form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", plot_crop_path(@plot_crop), "post" do
      assert_select "input#plot_crop_coverage[name=?]", "plot_crop[coverage]"
      assert_select "input#plot_crop_coverage_type[name=?]", "plot_crop[coverage_type]"
    end
  end
end
