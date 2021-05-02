class User < ApplicationRecord
  has_many :books, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image
  # refileが指定のカラムにアクセスするためにattachmentメソッドが必要

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { in: 2..20 }
  validates :email, presence: true
  # validates :password, presence: true
  # これを入れたらUpdateが上手く動作しなかった。なんで？
  validates :introduction, length: { maximum: 50 }

  # def books
  #   return Book.where(user_id: self.id)
  # end
  # book.showで使っている,has_many :booksで定義しているのでいらない
  # whereだと2件以上のデータを取ってくる、findメソッドだと1つしか取れない
  # whereだと(以下に取りたい情報を定義できる)
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy


  # ====================自分がフォローしているユーザーとの関連 ===================================
  #フォローする側のUserから見て、フォローされる側のUserを(中間テーブルを介して)集める。なので親はfollowing_id(フォローする側)
  has_many :active_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  # 中間テーブルを介して「follower」モデルのUser(フォローされた側)を集めることを「follower」と定義
  has_many :followers, through: :active_relationships, source: :followed
  # ========================================================================================


  # ====================自分がフォローされるユーザーとの関連 ===================================
  #フォローされる側のUserから見て、フォローしてくる側のUserを(中間テーブルを介して)集める。なので親はfollower_id(フォローされる側)
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  # 中間テーブルを介して「followed」モデルのUser(フォローする側)を集めることを「followed」と定義
  has_many :followeds, through: :passive_relationships, source: :follower
  # =======================================================================================

  def follower?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)フォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    active_relationships.find_by(followed_id: user.id).present?
  end


end
