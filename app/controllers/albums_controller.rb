class AlbumsController < ApplicationController
  before_action :authenticate_user!

  def index
    @albums = Album.all
  end

  def new
    @album = Album.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  private

  def album_params
    params[:category].permit(:name, :description, :private)
  end
end
