require 'spec_helper'

describe "plot_crops/index" do
  before(:each) do
    assign(:plot_crops, [
      stub_model(PlotCrop,
        :coverage => "9.99",
        :coverage_type => "Coverage Type"
      ),
      stub_model(PlotCrop,
        :coverage => "9.99",
        :coverage_type => "Coverage Type"
      )
    ])
  end

  it "renders a list of plot_crops" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Coverage Type".to_s, :count => 2
  end
end
