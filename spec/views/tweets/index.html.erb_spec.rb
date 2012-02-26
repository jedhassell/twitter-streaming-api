require 'spec_helper'

describe "tweets/index" do
  before(:each) do
    assign(:tweets, [
      stub_model(Tweet),
      stub_model(Tweet)
    ])
  end

  it "renders a list of tweets" do
    render
  end
end
