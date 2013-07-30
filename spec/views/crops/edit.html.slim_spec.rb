require 'spec_helper'

describe "crops/edit" do
  before(:each) do
    @crop = assign(:crop, stub_model(Crop,
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit crop form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", crop_path(@crop), "post" do
      assert_select "input#crop_name[name=?]", "crop[name]"
      assert_select "input#crop_description[name=?]", "crop[description]"
    end
  end
end
