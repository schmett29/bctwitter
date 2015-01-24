class TweetsController < ApplicationController

	def new
		@tweet = Tweet.new
	end

	def create
		@tweet = Tweet.create(tweet_params)
		flash.now[:success] = "Tweet Created"
		render 'new'
	end

	private

	def tweet_params
		params.require(:tweet).permit(:content)
	end
end
