class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :entry
	validates :user_id, presence: true
	validates :entry_id, presence: true
	validates :content, presence: true, length: {maximum: 200}
	default_scope -> { order('created_at DESC') }
end
