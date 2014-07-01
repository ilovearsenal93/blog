class Entry < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	 validates :user_id, presence: true
	 validates :title, presence: true, length: {maximum: 200}
	 validates :body, presence: true, length: { maximum: 2000 }
	 def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end
