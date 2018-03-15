class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    return if current_user.id == params[:idol]
    @subscription = Subscription.new(idol_id: params[:idol], follower: current_user)
    @subscription.save
  end

  def destroy
    @subscription = current_user.idols.where(idol_id: params[:id]).first
    @subscription.destroy
  end

  def idols
    subscriptions = current_user.idols
    @idols = User.where(id: subscriptions.pluck(:idol_id))
  end

  def followers
    subscriptions = current_user.followers
    @followers = User.where(id: subscriptions.pluck(:follower_id))
  end
end
