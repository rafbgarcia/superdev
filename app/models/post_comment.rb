class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :blog_post

  validates_presence_of :user_id, :blog_post_id
end
