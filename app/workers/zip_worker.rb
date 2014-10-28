class ZipWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"

  def perform(torrent_id, token, file_name)
    if File.exist?("#{TRANSMISSION_COMPLETED}/#{file_name}")
      system('zip','-r', '-9', '-j', "#{SPEAKEASY_BUTLER}/#{token}.zip", "#{TRANSMISSION_COMPLETED}/#{file_name}")
      package = Package.find_by torrent_id: torrent_id
      if package
        package.update(:is_available => true)
        package.save
        system('rm','-rf', "#{TRANSMISSION_COMPLETED}/#{file_name}")
      else
        raise "package not found - #{torrent_id}"
      end
    else
      raise "file doesn't exist - #{file_name}"
    end
  end
end
