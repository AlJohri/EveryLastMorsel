require 'spec_helper'

describe "varieties/show" do
  before(:each) do
    @variety = assign(:variety, stub_model(Variety))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
