require "spec_helper"

describe TweetsController do
  describe "routing" do

    it "routes to #index" do
      get("/tweets").should route_to("tweets#index")
    end

  end
end
