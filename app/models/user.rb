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
end
