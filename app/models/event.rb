class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :torrent
  scope :recent, -> { order("created_at desc").limit(15) }
end
