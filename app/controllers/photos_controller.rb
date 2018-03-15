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
  end

  private

  def photo_params
    params[:photo].permit(:name, :description, :image)
  end

  def user_photos
    current_user.photos.order(created_at: :desc).page(params[:page]).per(params[:per])
  end
  helper_method :user_photos
end
