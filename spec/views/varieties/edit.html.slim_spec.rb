require 'spec_helper'

describe "varieties/edit" do
  before(:each) do
    @variety = assign(:variety, stub_model(Variety))
  end

  it "renders the edit variety form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", variety_path(@variety), "post" do
    end
  end
end
