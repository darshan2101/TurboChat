class RoomsController < ApplicationController
  before_action :authenticate_user!
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
    @users = User.all_except(current_user)
    @messages = @active_room.messages.order(created_at: :asc)
    render 'index'
  end
end
