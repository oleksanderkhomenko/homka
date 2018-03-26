class SearchesController < ApplicationController
  def show
    if params[:q] =~ /\A@/
      @users = User.search_user_name(params[:q][1..-1])
    else
      @users = User.search(params[:q])
    end
  end
end
