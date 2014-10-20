class Torrent < ActiveRecord::Base
  attr_accessor :torrent_link
  validates :transmission_hash, :uniqueness => true
  belongs_to :uploader, class_name: "User"
  has_one :package, dependent: :destroy
end
