class SearchesController < ApplicationController
  def show
    @users = User.search(params[:q])
  end
end
