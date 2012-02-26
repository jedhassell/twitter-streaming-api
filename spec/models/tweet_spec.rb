require 'spec_helper'

describe Tweet do
  describe ".find_closest()" do
    it "Finds closest tweets" do
      200.times do
        Tweet.create!("text" => "tweet texting!!!", "location" => [100.02732856, 15.37509946],
                      "pic" => "http://a0.twimg.com/profile_images/1730221062/P31-12-11_17.29_02__normal.jpg",
                      "screen_name" => "pongpetchhz")
      end
      tweets = Tweet.where(:location.near(:sphere) => [-84.979248, 32.463426]).to_a
      tweets.size.should eq(100)
    end

    #it "excludes articles published at midnight one week ago" do
    #  article = Article.create!(:published_at => Date.today - 1.week)
    #  Article.recent.should be_empty
    #end
    #
    #it "excludes articles published more than one week ago" do
    #  article = Article.create!(:published_at => Date.today - 1.week - 1.second)
    #  Article.recent.should be_empty
    #end
  end
end