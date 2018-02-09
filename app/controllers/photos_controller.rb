class PhotosController < ApplicationController
  before_action :authenticate_user!

  def index
    @photos = current_user.photos
  end

  def new
    @album = current_user.albums.find(params[:album_id])
    @photo = Photo.new
  end

  def create
    album = current_user.albums.find(params[:album_id])
    photo_params[:image].each do |image|
      photo = Photo.new(image: image, user_id: current_user.id, album_id: album.id)
      photo.save
    end
    redirect_to album
  end

  def show
    @photo = current_user.photos.find(params[:id])
  end

  def destroy
  end

  private

  def photo_params
    params[:photo].permit(:name, :description, image: [])
  end
end
