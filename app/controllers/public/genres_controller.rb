class Public::GenresController < ApplicationController
  
  def search
    @genre = Genre.find(params[:id])
    @genres = Genre.all
  end
end
