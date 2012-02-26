class TweetsController < ApplicationController

  def closest_tweets
    if (longitude = params[:longitude].to_f) == 0.0
      @tweets = "Please enter a valid longitude"
    elsif (latitude = params[:latitude].to_f) == 0.0
      @tweets = "Please enter a valid latitude"
    else
      @tweets = Tweet.where(:location.near(:sphere) => [longitude, latitude]).limit(50).to_a
    end

    respond_to do |format|
      format.html { render :partial => 'closest_tweets' }
      format.json { render json: @tweets }
    end
  end
end
