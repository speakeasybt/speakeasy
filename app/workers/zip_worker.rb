class ZipWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high", retry: false

  def perform(torrent_id, token, file_name)
    if File.exist?("#{TRANSMISSION_COMPLETED}/#{file_name}")
      system('zip','-r', '-9', '-j', "#{SPEAKEASY_BUTLER}/#{token}.zip", "#{TRANSMISSION_COMPLETED}/#{file_name}")
      package = Package.find_by torrent_id: torrent_id
      if package
        package.update(:is_available => true)
        package.save
        # delete file
        system('rm','-rf', "#{TRANSMISSION_COMPLETED}/#{file_name}")

        # a very sad workaround
        # transmission daemon sometimes fails to respond without restart
        system('transmission-daemon')

        # delete torrent from transmission
        torrent = Torrent.find_by id: torrent_id
        torrent.transmission.delete!(true)
      else
        raise "package not found - #{torrent_id}"
      end
    else
      raise "file doesn't exist - #{file_name}"
    end
  end
end
