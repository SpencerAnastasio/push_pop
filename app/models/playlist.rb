class Playlist < ActiveRecord::Base
  has_many :songs
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :name, presence: { case_sensitive: false }, length: { maximum: 50 }
  validates :keycode, length: { maximum: 20 }
  validates :user_id, presence: true
end
