class TweetsController < ApplicationController

	before_action :authenticate_user!


	def new
		@tweet = Tweet.new
	end

	def create

		@tweet = Tweet.new(tweet_params)
		@tweet.user = current_user
		@tweet.save
		
		flash.now[:success] = "Tweet Created"
		render 'new'
	end

	private

	def tweet_params
		params.require(:tweet).permit(:content)
	end
end
