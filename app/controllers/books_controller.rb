class BooksController < ApplicationController

  def index
    @books = Book.all
    @book = Book.new
    @user = User.find(current_user.id)
    @users =User.all
  end

  def show
    # Perttern1
    @book = Book.find_by(id: params[:id])
    @book_new = Book.new

    @user = User.find_by(id: @book.user_id)
    # @book = Book.find(params[:id])
    # @book = Book.find(current_user.id)
    # @book = User.find(params[:id])
    # @user = User.find(params[:id])
    # @user = User.find(current_user.id)
    @books =Book.all
    @book_comment = BookComment.new

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # 投稿者(current_user.id)のid情報をBook投稿のuser_idコラムに入れて、ログインユーザをひも付ける
    # current_userはdeviseのメソッド
    @user = User.find(current_user.id)
    if @book.save
    flash[:notice] = "You have created new book successfully."
    redirect_to book_path(@book.id)
    # saveしてbook.showへ
    else
      @books = Book.all
      @users = User.all
      # コントローラーを通さないので、indexの中身を定義するため
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
    # newの場合インスタンスが空、editの場合すでにデータが入っている。それを判断するためにcontrollerを書き、
    # createアクションかupdateアクションに処理を引き継いでくれる

    # if @book.user != current_user.id
    # redirect_to books_path, alert: "不正なアクセスです"
    # end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "Update successfully."
    redirect_to book_path(@book.id)
    else
    render 'edit'
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
    else
    render 'index'
    end
  end

  def new
    @book = Book.new(user_params)
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
    redirect_to user_path
    end
  end

end
