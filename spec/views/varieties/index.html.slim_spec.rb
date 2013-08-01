require 'spec_helper'

describe "varieties/index" do
  before(:each) do
    assign(:varieties, [
      stub_model(Variety),
      stub_model(Variety)
    ])
  end

  it "renders a list of varieties" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
