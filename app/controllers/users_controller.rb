class UsersController < ApplicationController
  def show
    @user = User.where(user_name: params[:username]).first || User.find(params[:username])
    if @user
      redirect_to root_path if current_user && current_user.id == @user.id
      @albums = @user.albums.public_album
      @photos = @user.photos.where(album_id: @albums.pluck(:id)).page(params[:page])
    end
  end

  def show_album
    @user = User.where(user_name: params[:username]).first || User.find(params[:username])
    @album = @user.albums.public_album.find(params[:album_id])
    @photos = @album.photos.page(params[:page])
  end
end
