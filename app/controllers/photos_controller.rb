class PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :get_album, only: %i[new create]
  before_action :get_photo, only: %i[show update destroy]

  def index
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(image: photo_params[:image], user_id: current_user.id, album_id: @album.id)
    if @photo.save
      @feed = current_user.feeds.where(album_id: @album.id, updated_at: 30.seconds.ago..Time.current).first
      if @feed
        @feed.photo_ids.push(@photo.id)
        @feed.save!
      else
        @feed = current_user.feeds.create(album_id: @album.id, photo_ids: [@photo.id])
        val = { album: @photo.album, photos: [@photo], user: current_user, feed: @feed }
        ActionCable.server.broadcast(
          "feed_#{current_user.id}",
          action: :create,
          feed: render(partial: 'feeds/feed', locals: { value: val })
        )
      end
    end
  end

  def show
  end

  def update
    @photo.name = photo_params[:name]
    @photo.description = photo_params[:description]
    @photo.save! if @photo.changed?
  end

  def destroy
    feed = current_user.feeds.where(album_id: @photo.album_id).where("? = ANY (photo_ids)", @photo.id).first
    if feed
      feed.photo_ids.delete(@photo.id)
      feed.save!
      if feed.photo_ids.count.zero?
        feed.destroy
      end
    end
    @photo.destroy
  end

  private

  def photo_params
    params[:photo].permit(:name, :description, :image)
  end

  def get_album
    @album ||= current_user.albums.find(params[:album_id])
  end

  def get_photo
    @photo ||= current_user.photos.find(params[:id])
  end

  def user_photos
    current_user.photos.order(created_at: :desc).page(params[:page]).per(params[:per])
  end
  helper_method :user_photos
end
