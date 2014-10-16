class ZipWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"

  def perform(torrent_id, token, file_name)
    system('zip','-r', '-9', '-j', "#{Rails.root.to_s}/public/butler/#{token}.zip", "#{TRANSMISSION_COMPLETED}/#{file_name}")
    package = Package.find_by_torrent_id(torrent_id)
    package.update_attributes(:is_available => true)
    package.save
  end
end
