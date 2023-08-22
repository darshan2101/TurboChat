class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_status
  def index
    @rooms = Room.public_rooms
    @users = User.all_except(current_user)
    @room = Room.new
    
  end

  def create
    @room = Room.create(name: params[:room][:name])
  end


  def show
    @rooms = Room.public_rooms
    @active_room = Room.find(params[:id]) # if params[:id].present?
    @room = Room.new
    @message = Message.new

    pagy_messages = @active_room.messages.order(created_at: :desc)
    @pagy, messages = pagy(pagy_messages, items: 8)
    @messages = messages.reverse

    @users = User.all_except(current_user)
    render 'index'
  end

  private
    def set_status
      current_user.update!(status: User.statuses[:online]) if current_user
    end
end
