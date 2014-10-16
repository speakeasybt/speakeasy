class Package < ActiveRecord::Base
  validates :torrent_id, :uniqueness => true
end
