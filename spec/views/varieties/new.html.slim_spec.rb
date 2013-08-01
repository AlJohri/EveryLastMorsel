require 'spec_helper'

describe "varieties/new" do
  before(:each) do
    assign(:variety, stub_model(Variety).as_new_record)
  end

  it "renders new variety form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", varieties_path, "post" do
    end
  end
end
