class ZipWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"

  def perform(torrent_id, token, file_name)
    if File.exist?("#{TRANSMISSION_COMPLETED}/#{file_name}")
      system('7z','a', '-r', "#{Rails.root.to_s}/public/butler/#{token}.7z", "#{TRANSMISSION_COMPLETED}/#{file_name}")
      package = Package.find_by_torrent_id(torrent_id)
      if package
        package.update_attributes(:is_available => true)
        package.save
        system('rm','-rf', "#{TRANSMISSION_COMPLETED}/#{file_name}")
      else
        raise "package not found #{torrent_id}"
      end
    else
      raise "file doesn't exist - #{file_name}"
    end
  end
end
