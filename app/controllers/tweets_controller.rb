class TweetsController < ApplicationController
  before_action :set_tweet_post
  skip_before_action :require_login

  def tweet
  end
end