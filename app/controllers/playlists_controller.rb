class PlaylistsController < ApplicationController

  before_action :signed_in_user, only: [:index, :create,]
  before_action :correct_user,   only: :destroy

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = current_user.playlists.build(playlist_params)
    if @playlist.save
      flash[:success] = "Playlist created!"
      redirect_to playlist_path(@playlist.id)
    else
      render :new
    end
  end

  def show
    @playlist = Playlist.find(params[:id])
  end

  def index
    @playlists = Playlist.paginate(page: params[:page])
  end

  def edit
    @playlist = Playlist.find(params[:id])
  end

  def update
  end

  def destroy
    @playlist.destroy
    flash[:success] = "Playlist deleted."
    redirect_to @playlist.user
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name)
  end

  # Before filters

  def correct_user
      @playlist = current_user.playlists.find(params[:id])
    end

end
