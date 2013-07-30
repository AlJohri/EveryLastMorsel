require "spec_helper"

describe PlotCropVarietiesController do
  describe "routing" do

    it "routes to #index" do
      get("/plot_crop_varieties").should route_to("plot_crop_varieties#index")
    end

    it "routes to #new" do
      get("/plot_crop_varieties/new").should route_to("plot_crop_varieties#new")
    end

    it "routes to #show" do
      get("/plot_crop_varieties/1").should route_to("plot_crop_varieties#show", :id => "1")
    end

    it "routes to #edit" do
      get("/plot_crop_varieties/1/edit").should route_to("plot_crop_varieties#edit", :id => "1")
    end

    it "routes to #create" do
      post("/plot_crop_varieties").should route_to("plot_crop_varieties#create")
    end

    it "routes to #update" do
      put("/plot_crop_varieties/1").should route_to("plot_crop_varieties#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/plot_crop_varieties/1").should route_to("plot_crop_varieties#destroy", :id => "1")
    end

  end
end
