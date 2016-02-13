module NoBrainer::Streams
  extend ActiveSupport::Concern

  def stream_from(query, options = {}, callback = nil)
    callback ||= -> (changes) do
      transmit changes, via: "streamed from #{query.inspect}"
    end

    # defer_subscription_confirmation!
    @cursors ||= []
    cursor = query.raw.changes(options)
    @cursors << cursor

    Concurrent.global_io_executor.post do
      cursor.each(&callback)
    end
  end
end
