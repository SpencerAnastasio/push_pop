class PlaylistSong < ActiveRecord::Base
  belongs_to :song
  belongs_to :playlist

  validates :song_id, presence: true
  validates :playlist_id, presence: true 
end
