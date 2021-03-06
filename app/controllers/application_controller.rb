class ApplicationController < ActionController::Base
  before_action :authenticate_user!,except: [:top, :about]
  # before_action :authenticate_user!,only:[:edit, :update, :destroy, :show]
  # ログインユーザーだけがonly以下で記載したアクションを実行できる
  # サインインしていない時なんでsignup画面に飛ぶの？？

  before_action :configure_permitted_parameters, if: :devise_controller?
  # devise利用の機能（ユーザ登録、ログイン認証など）が使われる場合、その前にconfigure_permitted_parametersが実行される
  # if:はbefore_actionのオプションの一つで、値にメソッド名を指定することで、その戻り値がtrueであるとき
  # のみ処理を実行するように設定。：devise_controller?というdeviseのヘルパーメソッド名を指定している
  # deviseにまつわる画面に行った時に、という意味。こうすることで全ての画面でconfigure_permitted_parametersをするのを防いでいる
  protected
  # private
  # protectedは呼び出された他のコントローラからも参照できる

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[
      :email,
      :name,
      :postcode,
      :prefecture_code,
      :address_city,
      :address_street,
      :address_building
      ])
    # sign_upの時にemailを許可する
  end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:name,:email])
  # end
  # いらない、なくてログインが動く

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
    # 遷移先はshow.idなので、（）のcurrent_user.idを取ってくる作業をさすれないように！！
    # signup = create => signin、なのでsigninだけ遷移先を設定すれば
  end

  def after_sign_out_path_for(resource)
    root_path
    # 遷移先はshow.idなので、（）のcurrent_user.idを取ってくる作業をさすれないように！！
    # signup = create => signin、なのでsigninだけ遷移先を設定すれば
  end

  # def after_sign_in_path_for(resource)
  # ログイン時に実行されるメソッドで、同様にログイン時に飛んでほしいページを指定できる
  #   if current_user
  #     flash[:notice] = "ログインに成功しました"
  #     user_path  #　指定したいパスに変更
  #   else
  #     flash[:notice] = "新規登録完了しました。次に名前を入力してください"
  #     user_path  #　指定したいパスに変更
  #   end
  # end
end