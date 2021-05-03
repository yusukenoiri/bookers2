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
end
