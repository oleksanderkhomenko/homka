class HomeController < ApplicationController
  def index
    if current_user && current_user.idols.count > 0
      subscriptions = current_user.idols
      idols = User.where(id: subscriptions.pluck(:idol_id))
      albums = Album.where(user_id: idols.pluck(:id)).public_album
      photos = Photo.where(album_id: albums.pluck(:id)).order(created_at: :desc)
      @feed = photos.group_by { |p| [p.created_at.to_time.strftime('%B %e at %l:%M %p'), p.album_id] }
    end
  end
end
