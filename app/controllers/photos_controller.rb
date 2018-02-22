class PhotosController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @album = current_user.albums.find(params[:album_id])
    @photo = Photo.new
  end

  def create
    @album = current_user.albums.find(params[:album_id])
    @photo = Photo.new(image: photo_params[:image], user_id: current_user.id, album_id: @album.id)
    @photo.save
    @photo.reload
  end

  def show
    @photo = current_user.photos.find(params[:id])
  end

  def destroy
    @photo = current_user.photos.find(params[:id])
    @photo.destroy
    if params[:album_id].present?
      redirect_to album_path(params[:album_id])
    else
      redirect_to photos_path
    end
  end

  private

  def photo_params
    params[:photo].permit(:name, :description, :image)
  end

  def user_photos
    current_user.photos.order(:id)
  end
  helper_method :user_photos
end
