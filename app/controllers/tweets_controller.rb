class TweetsController < ApplicationController

	before_action :authenticate_user!


	def new
		@tweet = Tweet.new
		@tweets = current_user.tweets
	end

	def create

		@tweet = Tweet.new(tweet_params)
		@tweet.user = current_user
		@tweets = current_user.tweets

		if @tweet.save
			flash[:success] = "Tweet Created"
			redirect_to new_tweet_path
		else
			flash.now[:danger] = "did not work"
			render 'new'
		end
		
	end

	def index
		@tweets = Tweet.all.reject{ |tweet| tweet.user == current_user }
		@relationship = Relationship.new
	end

	private

	def tweet_params
		params.require(:tweet).permit(:content)
	end
end
