class RoomChannel < ApplicationCable::Channel
  include NoBrainer::Streams

  def subscribed
    first_room = Room.first || Room.create(name: 'First Room')
    stream_from first_room.messages, {}, -> (changes) do
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
