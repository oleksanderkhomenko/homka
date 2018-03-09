class UsersController < ApplicationController
  def show
    @user = User.where(user_name: params[:username]).first || User.find(params[:username])
    if @user
      @albums = @user.albums.public_album
    end
  end

  def show_album
    @user = User.where(user_name: params[:username]).first || User.find(params[:username])
    @album = @user.albums.public_album.find(params[:album_id])
    @photos = @album.photos
  end
end
