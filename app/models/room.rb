class Room
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :name, :type => String, :index => true

  has_many :messages
end
