class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order("created_at DESC")
  end
end
