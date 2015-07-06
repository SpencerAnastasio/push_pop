class Song < ActiveRecord::Base
  belongs_to :user
  belongs_to :playlist
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :artist, presence: true
  validates :user_id, presence: true
  validates :path, presence: true
  validates :playlist_id, presence: true
  mount_uploader :path, SongUploader
end
