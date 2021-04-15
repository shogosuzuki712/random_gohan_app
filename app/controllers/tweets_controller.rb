class TweetsController < ApplicationController
  
  def index
  
  end

  def new
    @tweet = Tweet.new
  end
  
  def create
    @tweet = Tweet.new(tweet_params)
    unless @tweet.save
      render :new
    end
  end
  
  private

  def tweet_params
    params.require(:tweet).permit(:title, :text, :image).merge(user_id: current_user.id)
  end
end
