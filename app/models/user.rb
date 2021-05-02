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
end
