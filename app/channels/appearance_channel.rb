class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "appearance_channel"

    #current_user.update(status: User.statuses[:online])
  end

  def unsubscribed
    stop_stream_from "appearance_channel"
    offline
  end

  def online
    status = User.statuses[:online]
    broadcast_status(status)
  end

  def offline
    status = User.statuses[:offline]
    broadcast_status(status)
  end

  def away
    status = User.statuses[:away]
    broadcast_status(status)
  end

  def recieve(data)
    ActionCable.server.broadcast("appearance_channel", data)
  end

  private
    def broadcast_status(status)
      current_user.update!(status: status)
    end
end
