require "spec_helper"

describe PlotCropsController do
  describe "routing" do

    it "routes to #index" do
      get("/plot_crops").should route_to("plot_crops#index")
    end

    it "routes to #new" do
      get("/plot_crops/new").should route_to("plot_crops#new")
    end

    it "routes to #show" do
      get("/plot_crops/1").should route_to("plot_crops#show", :id => "1")
    end

    it "routes to #edit" do
      get("/plot_crops/1/edit").should route_to("plot_crops#edit", :id => "1")
    end

    it "routes to #create" do
      post("/plot_crops").should route_to("plot_crops#create")
    end

    it "routes to #update" do
      put("/plot_crops/1").should route_to("plot_crops#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/plot_crops/1").should route_to("plot_crops#destroy", :id => "1")
    end

  end
end
