class Book < ApplicationRecord
    belongs_to :user, optional: true
    
    validates :title, presence: true
    validates :body, presence: true
    validates :body, length: { maximum: 200 }
    
    def user
    #インスタンスメソッドないで、selfはインスタンス自身を表す
        return User.find_by(id: self.user_id)
    end
    
end
