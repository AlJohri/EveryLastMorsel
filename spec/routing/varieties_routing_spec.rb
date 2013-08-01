require "spec_helper"

describe VarietiesController do
  describe "routing" do

    it "routes to #index" do
      get("/varieties").should route_to("varieties#index")
    end

    it "routes to #new" do
      get("/varieties/new").should route_to("varieties#new")
    end

    it "routes to #show" do
      get("/varieties/1").should route_to("varieties#show", :id => "1")
    end

    it "routes to #edit" do
      get("/varieties/1/edit").should route_to("varieties#edit", :id => "1")
    end

    it "routes to #create" do
      post("/varieties").should route_to("varieties#create")
    end

    it "routes to #update" do
      put("/varieties/1").should route_to("varieties#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/varieties/1").should route_to("varieties#destroy", :id => "1")
    end

  end
end
