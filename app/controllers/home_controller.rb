class HomeController < ApplicationController
  def index
    if current_user && current_user.idols.count > 0
      subscriptions = current_user.idols
      idols = User.where(id: subscriptions.pluck(:idol_id))
      albums = Album.where(user_id: idols.pluck(:id)).public_album
      @feeds = Feed.where(user_id: idols, album_id: albums).order(updated_at: :desc).page(params[:page]).per(10)
      @feed = @feeds.map do |feed|
        album = albums.find(feed.album_id)
        photos = Photo.where(id: feed.photo_ids).order(created_at: :desc)
        user = idols.find(feed.user_id)
        {album: album, photos: photos, user: user, feed: feed}
      end
    end
  end
end
