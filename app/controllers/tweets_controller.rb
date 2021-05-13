class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :search]
  before_action :set_tweet,          only: [:edit, :update, :destroy]
  before_action :conditions,         only: [:edit, :update, :destroy]

  def index
    @tweet = Tweet.all.order('created_at DESC')
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def destroy
    @tweet.destroy
  end

  def search
    @tweet = Tweet.where('id >= ?', rand(Tweet.first.id..Tweet.last.id)).first
  end

  private

  def conditions
    unless @tweet.user.id == current_user.id
      redirect_to action: :index
    end
  end

  def tweet_params
    params.require(:tweet).permit(:title, :text, :image).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
