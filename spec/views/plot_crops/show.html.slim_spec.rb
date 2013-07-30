require 'spec_helper'

describe "plot_crops/show" do
  before(:each) do
    @plot_crop = assign(:plot_crop, stub_model(PlotCrop,
      :coverage => "9.99",
      :coverage_type => "Coverage Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/9.99/)
    rendered.should match(/Coverage Type/)
  end
end
