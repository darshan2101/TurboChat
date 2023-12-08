class RoomsController < ApplicationController
	include RoomsHelper
	before_action :authenticate_user!
	before_action :set_status

	def index
		@rooms = search_rooms
		@joined_rooms = current_user.joined_rooms.order(last_message_at: :desc)
		@users = User.all_except(current_user)
		@room = Room.new

	end

	def create
		@room = Room.create(name: params[:room][:name])
		redirect_to @room
	end

	def show
		@rooms = search_rooms
		@joined_rooms = current_user.joined_rooms.order(last_message_at: :desc)
		@active_room = Room.find(params[:id]) # if params[:id].present?
		@room = Room.new
		@message = Message.new

		pagy_messages = @active_room.messages.includes(:user).order(created_at: :desc)
		@pagy, messages = pagy(pagy_messages, items: 8)
		@messages = messages.reverse

		@users = User.all_except(current_user)
		render 'index'
	end

	def search
		@rooms = search_rooms
		respond_to do |format|
			format.turbo_stream do
				render turbo_stream: [
						turbo_stream.update('search_results',
						partial: 'rooms/search_results',
						locals: {rooms: @rooms}
					)
				]
			end
		end
	end

	def join
		@room = Room.find(params[:id])
		current_user.joined_rooms << @room
		redirect_to @room
	end

	def leave
		@room = Room.find(params[:id])
		current_user.joined_rooms.delete(@room)
		redirect_to rooms_path
	end

	private
		def set_status
			current_user.update!(status: User.statuses[:online]) if current_user
		end
end
