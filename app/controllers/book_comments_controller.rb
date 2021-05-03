class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = @book.id
    comment.save
    # @user = current_user
    @user = User.find_by(id: @book.user_id)
    
    # @book_comment = BookComment.new
    # redirect_to book_path(book)
  end

  def destroy
    # BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    # # id:,book_idはbook_comment modelのカラム、コメントを特定する為にどのbookに属するか。
    # # コメントのid
    # redirect_to book_path(params[:book_id])

    book = Book.find(params[:book_id])
    # findにしたらkeyはid, book_idはvalue,culumnからとってきているのではない
    comment = current_user.book_comments.find_by(id: params[:id])
    comment.destroy
    redirect_to book_path(book)
  end

  private

  def book_comment_params
    # binding.pry
    params.require(:book_comment).permit(:comment)
  end
end
