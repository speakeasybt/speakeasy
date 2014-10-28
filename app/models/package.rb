class Package < ActiveRecord::Base
  validates :torrent_id, :uniqueness => true
  belongs_to :torrent
end
