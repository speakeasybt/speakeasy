class Torrent < ActiveRecord::Base
  attr_accessor :torrent_link
  validates :transmission_hash, :uniqueness => true
  belongs_to :uploader, class_name: "User"
  has_one :package, dependent: :destroy
  scope :active, -> { where(soft_delete: false) }
  scope :deleted, -> { where(soft_delete: true) }

  def transmission
    Transmission.torrents.find { |torrent| torrent.hash == "#{self.transmission_hash}" }
  end

  def uploaded_at
    self.created_at.strftime("%B %d, %Y, %I:%m%P")
  end

  def editable_by?(user)
    if self.uploader == user || user.is_staff?
      true
    else
      false
    end
  end
end
