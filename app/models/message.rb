class Message
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :text, :type => String

  belongs_to :user
  belongs_to :room
end
