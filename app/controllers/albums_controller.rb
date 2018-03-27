class AlbumsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_album, only: %i[edit update show destroy user_album_photos]

  def index
  end

  def new
    @album = Album.new
  end

  def create
    @album = current_user.albums.create(album_params)
    if @album.errors.any?
      @errors = @album.errors.full_messages
    end
  end

  def edit
  end

  def update
    @album.name = album_params[:name]
    @album.description = album_params[:description]
    @album.private = album_params[:private]
    @album.save! if @album.changed?
  end

  def show
  end

  def destroy
    feed = @album.feeds.pluck(:id)
    ActionCable.server.broadcast(
      "feed_#{current_user.id}",
      action: :destroy,
      feed_ids: feed,
      delete_feed: true
    )
    @album.destroy
    redirect_to albums_path
  end

  private

  def album_params
    params[:album][:private] = params[:album][:private].to_i
    params[:album].permit(:name, :description, :private)
  end

  def get_album
    @album ||= current_user.albums.find(params[:id])
  end

  def user_albums
    current_user.albums.order(:id)
  end

  def user_album_photos
    @album.photos.order(created_at: :desc).page(params[:page]).per(params[:per])
  end
  helper_method :user_albums, :user_album_photos
end
