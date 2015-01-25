class Tweet < ActiveRecord::Base
include Twitter::Extractor

	belongs_to :user
	validates :content, length: { maximum: 140}

	def extract_hash_tags
		extract_hashtags(self.content)
	end

	validate :hashtags_created

	def hashtags_created
		begin
			transaction do
				@hashtags = self.extract_hash_tags
				puts "before each"
				@hashtags.each do |the_hashtag|
					puts "the hashtag is #{the_hashtag}"
					if Hashtag.where(tag: the_hashtag).any?
						puts "1"
						#do nothing
					else
						if Hashtag.create!(tag: the_hashtag)
							puts "2"
							#do nothing
						else
							puts "3"
							self.errors.add(:tweet, "The Hashtag is invalid")
						end
					end
				end
				puts "after each"
			end
		rescue
			puts "4"
			self.errors.add(:tweet, "The hashtag(s) are invalid")
		end		
	end


end
