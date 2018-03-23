class FeedChannel < ApplicationCable::Channel
  def subscribed
    current_user.idols.pluck(:idol_id).each do |idol|
      stream_from "feed_#{idol}"
    end
  end

  def unsubscribed
  end
end
