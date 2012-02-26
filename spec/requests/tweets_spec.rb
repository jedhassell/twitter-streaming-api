require 'spec_helper'

describe "Tweets" do
  describe "/" do
    it "displays tweets after long and lat entered" do
      100.times do
        Tweet.create!("text" => "tweet texting!!!", "location" => [100.02732856, 15.37509946],
                      "pic" => "http://a0.twimg.com/profile_images/1730221062/P31-12-11_17.29_02__normal.jpg",
                      "screen_name" => "pongpetchhz")
      end

      get "/"

      assert_select "input[name=?]", "longitude"
      assert_select "input[name=?]", "latitude"
      assert_select "button[type=?]", "submit"


      post "/tweets/closest_tweets", :longitude => '21', :latitude => '21'
      assert_not_equal "#tweet_container", :text => ""
    end
  end
end