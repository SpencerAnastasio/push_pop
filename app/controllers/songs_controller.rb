class SongsController < ApplicationController

  before_action :correct_user,   only: :destroy

  def new
    @song = Song.new
    @playlist = Playlist.find(params[:playlist_id])
  end

  def create
    @song = current_user.songs.build(song_params)
    if @song.save
      flash[:success] = "Track added!"
      redirect_to playlist_path(@song.playlist_id)
    else
      render :new
    end
  end

  def destroy
    @song.destroy
    flash[:success] = "Track deleted"
    redirect_to @song.playlist
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist, :path, :playlist_id)
  end

  # Before filters

  def correct_user
    @song = current_user.songs.find(params[:id])
  end

end
