require "rails_helper"

RSpec.describe AcademiaController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/academia").to route_to("academia#index")
    end

    it "routes to #new" do
      expect(:get => "/academia/new").to route_to("academia#new")
    end

    it "routes to #show" do
      expect(:get => "/academia/1").to route_to("academia#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/academia/1/edit").to route_to("academia#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/academia").to route_to("academia#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/academia/1").to route_to("academia#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/academia/1").to route_to("academia#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/academia/1").to route_to("academia#destroy", :id => "1")
    end

  end
end
