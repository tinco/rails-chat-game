# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
require 'nobrainer_streams'

class RoomChannel < ApplicationCable::Channel
  include NoBrainer::Streams

  def subscribed
    stream_from Room.first.messages, {}, -> (changes) do
      transmit message: render_message(changes['new_val'])
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create(user: User.first, room: Room.first, text: data['message'])
  end

  private

  def render_message(message)
    message = Message.new(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: {message: message})
  end
end
