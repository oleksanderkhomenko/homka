class UsersController < ApplicationController
  before_action :get_user, only: %i[show show_album]

  def show
    if @user
      redirect_to root_path if current_user && current_user.id == @user.id
      @albums = @user.albums.public_album
      @photos = @user.photos.where(album_id: @albums.pluck(:id)).page(params[:page])
    end
  end

  def show_album
    @album = @user.albums.public_album.find(params[:album_id])
    @photos = @album.photos.page(params[:page])
  end

  def change_locale
    cookies[:locale] = params[:locale]
  end

  private

  def get_user
    @user ||= User.where(user_name: params[:username]).first || User.find(params[:username])
  end
end
