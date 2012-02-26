require 'spec_helper'

describe Tweet do
  describe ".find_closest()" do
    it "Finds closest tweets" do
      tweets = Tweet.where(:location.near(:sphere) => [-84.979248, 32.463426])
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