class TweetsController < ApplicationController
  # GET /tweets
  # GET /tweets.json
  #def index
  #
  #end

  def closest_tweets
    if (longitude = params[:longitude].to_f) == 0.0
      @tweets = "Please enter a valid longitude"
    elsif (latitude = params[:latitude].to_f) == 0.0
      @tweets = "Please enter a valid Longitude"
    else
      @tweets = Tweet.where(:location.near(:sphere) => [longitude, latitude]).limit(50).to_a
    end
    render :partial => 'closest_tweets'
  end

  #def map
  #
  #end

  def map_click
    @tweets = Tweet.where(:location.near(:sphere) => [params[:lng].to_f, params[:lat].to_f]).limit(50).to_a
    render :json => @tweets.to_json
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
    @tweet = Tweet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tweet }
    end
  end
end
