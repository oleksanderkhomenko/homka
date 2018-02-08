class PhotosController < ApplicationController
  def index
  end
  def new
    @photo = Photo.new
    @album = Album.find(params[:album_id])
  end
  def create
    @album = Album.find(params[:album_id])
    byebug
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    @photo.album_id = @album.id
    @photo.save
    redirect_to @album
  end
  def show
  end
  def destroy
  end

  private

  def photo_params
    params[:photo].permit(:name, :description, :image)
  end
end
