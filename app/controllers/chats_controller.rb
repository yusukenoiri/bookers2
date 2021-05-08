class ChatsController < ApplicationController
  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    # plunkメソッドは引数としてカラム名のリストを与えると、指定したカラムの値の配列を、対応するデータ型で返す
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    if user_rooms.nil?
      @room = Room.new
      @room.save
      UserRoom.create(user_id: @user.id, room_id: @room.id)
      UserRoom.create(user_id:current_user.id, room_id: @room.id)
    else
      @room = user_rooms.room
    end
      @chats = @room.chats
      @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    @room = @chat.room
    @chats = @room.chats
  end

  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
