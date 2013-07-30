require 'spec_helper'

describe "plot_crops/new" do
  before(:each) do
    assign(:plot_crop, stub_model(PlotCrop,
      :coverage => "9.99",
      :coverage_type => "MyString"
    ).as_new_record)
  end

  it "renders new plot_crop form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", plot_crops_path, "post" do
      assert_select "input#plot_crop_coverage[name=?]", "plot_crop[coverage]"
      assert_select "input#plot_crop_coverage_type[name=?]", "plot_crop[coverage_type]"
    end
  end
end
