class UsersController < ApplicationController
  # Application contorollerを継承している
  # Applicationコントローラーも読み込まれる

  # before_action :authenticate_user!
  # before_action :authenticate_user!, only: [:show]とかにもできる

  before_action :current_user, only: [:edit]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # user_paramsに投稿データtitleとbodyを渡す
    if @user.save
    flash[:notice] = "You have created new User successfully."
    redirect_to user_path(@user.id)
    # saveしてusers.showへ
    else
      render 'index'
      # render :アクション名で、同じコントローラ内の別アクションのViewを表示
      # renderはコントローラーを通さない,renderされた後にindex.htmlにいく、if error文に引っかかり表示される
    end
  end

  def index

    @user = User.find(current_user.id)
    # @user = User.find(params[:id])
    @users = User.all
    @book = Book.new
  # render "books/index"　bookコントローラーへの呼び出し？
  # 書いてない場合はrender user.indexが呼び出される
  end

  def show
    # @user = User.find(current_user.id)
    @user = User.find(params[:id])
    # ユーザのデータを1件取得し、インスタンス変数へ渡す
    @book = Book.new
    @books = @user.books

  end

  def destroy
  end

  # def edit
  # end
  def edit
    if params[:id].to_i == current_user.id
      @user = User.find(params[:id])
      render 'edit'
    else
      @book = Book.new
      @books = Book.all
      @user = current_user
      # render 'show'
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "Updated successfully."
    redirect_to user_path(@user.id)
    else
    flash[:notice] = "Update was not successfully done."
    # redirect_to edit_user_path(current_user.id)
    render 'edit'
    end
  end

  # def update
  #   @user = User.find(params[:id])
  #   if @user.update(user_params)
  #   flash[:notice] = "Update successfully."
  #   redirect_to user_path(@user.id)
  #   else
  #   @user = User.find(params[:id])
  #   render 'edit'
  #   end
  # end

  private
  # ストロングパラメータ
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path(user.id)
    end
  end
end
