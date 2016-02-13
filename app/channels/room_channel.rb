# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
    defer_subscription_confirmation!

    Concurrent.global_io_executor.post do
      Room.first.messages.raw.changes.each do |changes|
        transmit render_message(changes["new_val"]), via: "streamed from room_channel"
      end
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create(user: User.first, room: Room.first, text: data['message'])
  end

  def render_message(message)
    message = Message.new(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: {message: message})
  end
end
