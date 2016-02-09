class Entity < ApplicationRecord
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  include EntityComponents::NoBrainer
end
