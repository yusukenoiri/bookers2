class Book < ApplicationRecord
    belongs_to :user, optional: true
    # optional: trueで外部キーのnilを許可できるようになる

    validates :title, presence: true
    validates :body, presence: true
    validates :body, length: { maximum: 200 }

    def user
    #インスタンスメソッドないで、selfはインスタンス自身を表す
        return User.find_by(id: self.user_id)
    end
    has_many :favorites, dependent: :destroy

    has_many :book_comments, dependent: :destroy

    def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
        # @book.favoritesの中に、引数で送られたuserのidがあるかどうか？
    end

    def self.search(search,word)
        if search == 'forword_match'
             @book = Book.where("title LIKE?", word + "%")
        elsif search == 'backword_match'
             @book = Book.where("title LIKE?", "%" + word)
        elsif search == 'perfect_match'
             @book = Book.where(title: word)
        elsif search == 'partial_match'
             @book = Book.where("title LIKE?", "%" + word + "%")
        else
             @book = Book.all
        end
    end

    def self.create_test
        Book.create(title: "test", body: "testtest", )
    end
    # クラスメソッドとは？
    # ざっくりの認識では、クラス全体の中から何かを取り出す際に使用するもの
    # 一つ一つのインスタンスには紐づいておらず、クラスに対して働きかけるメソッド、とも言い換えられる
    # メソッドの呼び出しには、必ずレシーバが必要になり、クラスメソッドには、あらかじめレシーバとして
    # self(自分自身のオブジェクト)が指定されているので、クラスから直接呼び出せる仕掛けになっている
end
