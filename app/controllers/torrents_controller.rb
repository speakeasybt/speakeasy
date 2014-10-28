class TorrentsController < ApplicationController
  before_action :torrent_params
  before_action :check_staff_authorization, :only => [:update, :destroy]

  def index
    @torrents = Torrent.all.order("id desc")
  end

  def show
    @torrent = Torrent.find_by id: params[:id]
  end

  def new
    @torrent = Torrent.new
  end

  def create
    torrent = Torrent.new
    torrent.title = params[:torrent][:title]
    torrent.description = params[:torrent][:description]
    torrent.uploader_id = current_user.id

    # add torrent into transmission
    transmission = Transmission::RPC::Torrent + "#{params[:torrent][:torrent_link]}"

    # add transmission_hash
    torrent.transmission_hash = transmission.hash

    if transmission && torrent.save
      redirect_to root_url, :notice => "Successfull added #{torrent.title}"
    else
      redirect_to new_torrent_url, :alert => "An error occured. #{params[:torrent]}"
    end
  end

  def destroy
    torrent = Torrent.find_by_id(params[:id])
    # delete from butler
    if torrent
      system('rm','-rf', "#{SPEAKEASY_BUTLER}/#{torrent.file_name}")
      torrent.destroy
      redirect_to root_url, :notice => "Torrent deleted."
    else
      redirect_to root_url, :alert => "An error occured while attempting to delete torrent."
    end
  end

  def package
    torrent = Torrent.find_by_id params[:id]

    if torrent
      # generate random file name
      token = SecureRandom.hex(32)

      # create package
      Package.create(:torrent_id => torrent.id, :user_id => current_user.id, :file_token => token)

      # set file name now that transmission has everything ready
      torrent.file_name = torrent.transmission.name
      if torrent.save
        # create zip
        ZipWorker.perform_async(torrent.id, token, torrent.file_name)
        redirect_to torrent_path(torrent.id), :notice => "Packaging process has started."
      else
        redirect_to torrent_path(torrent.id), :alert => "Error occured (invalid file name)"
      end
    else
      redirect_to root_url, :alert => "Invalid packaging request!"
    end
  end

  private
    def torrent_params
      params.permit(:torrent, :title, :uploader_id, :file_name, :download_count, :category_id, :description)
    end
end
