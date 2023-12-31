class UsersController < ApplicationController
    include RoomsHelper
    def show
        @user =  User.find(params[:id])
        @users = User.all_except(current_user)

        @room = Room.new
        @rooms = search_rooms
        @room_name = get_name(@user, current_user)
        @active_room = Room.where(name: @room_name).first || Room.create_private_room([@user, current_user] , @room_name)
        current_user.update(current_room: @active_room)

        @message = Message.new

        pagy_messages = @active_room.messages.order(created_at: :desc)
        @pagy, messages = pagy(pagy_messages, items: 10)
        @messages = messages.reverse

        render 'rooms/index'
    end

end
