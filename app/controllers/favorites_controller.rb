class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id:book.id)
    favorite.save
    redirect_to books_path

    # favorite = current_user.favorites.build(book_id: params[:book_id])
    # favorite.save
    # redirect_to books_path
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id:book.id)
    # いいねしているもの全てをとる、それに紐づくbookのidを一つとってくる
    favorite.destroy
    redirect_to books_path

    # favorite = current_user.favorites.find_by(book_id: params[:book_id])
    # favorite.destroy
    # redirect_to books_path
  end
end
