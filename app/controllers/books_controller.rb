class BooksController < ApplicationController
  def new
  end

  def create
  end

  def index
    @book =Book.find(params[:id])
  end

  def show
  end
  
  def edit
  end

  def destroy
  end
end
