class RelationshipsController < ApplicationController
  def create
    # こう記述することで、「current_userに関連したFavoriteクラスの新しいインスタンス」が作成可能。
    # favorite.user_id = current_user.idが済んだ状態で生成されている。
    # buildはnewと同じ意味で、アソシエーションしながらインスタンスをnewする時に形式的に使われる。
    follow = current_user.active_relationships.build(followed_id: params[:user_id])

    # byebug
    follow.save!
    redirect_to request.referer
  end

  def destroy
    follow = current_user.active_relationships.find_by(followed_id: params[:user_id])
    follow.destroy
    redirect_to request.referer
  end
end
