class HashtagsController < ApplicationController
	def show
		@hashtag = Hashtag.where(tag: params[:hash_tag_id]).first
		@tweets = Tweet.all

		if @hashtag
			@filtered_tweets = @tweets.select {|t| t.extract_hash_tags.include?(@hashtag.tag) }
		else
			@filtered_tweets = Array.new
			flash.nowp[:notice] = "There are no tweets with #{params[:hash_tag_id]}"
		end
	end
end
