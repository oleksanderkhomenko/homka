class AlbumsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_album, only: %i[edit update show destroy user_album_photos]

  def index
  end

  def new
    @album = Album.new
  end

  def create
    @album = current_user.albums.new(album_params)
    @album.save
    #   redirect_to @album
    # else
    #   render :new
    # end
  end

  def edit
  end

  def update
    @album.update(album_params)
    redirect_to @album
  end

  def show
    @photos = @album.photos
  end

  def destroy
    @album.destroy
    redirect_to albums_path
  end

  private

  def album_params
    params[:album].permit(:name, :description, :private)
  end

  def get_album
    @album ||= current_user.albums.find(params[:id])
  end

  def user_albums
    current_user.albums.order(:id)
  end

  def user_album_photos
    @album.photos.order(:id)
  end
  helper_method :user_albums, :user_album_photos
end
