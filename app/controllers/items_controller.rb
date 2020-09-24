class ItemsController < ApplicationController
    before_action :set_playlist
    before_action :set_item, except: [:create]
    before_action :authenticate_user!

    def create
        @item = @playlist.items.build()
        @item.ytlink = params[:ytlink]

        if @item.save
            render :status => 201, :json => @item
        else
            err_msg = @item.errors.empty?? 'Save failed' : @item.errors.full_messages.join('; ')
            render :status => 400, :json => { message: err_msg }
        end
    end

    def destroy
        if @item.destroy
            render json: {
                status: 200
            }
        end
    end

    private

    def set_playlist
        @playlist = Playlist.find(params[:playlist_id])
    end

    def set_item
        @item = @playlist.items.find(params[:id])
    end

    def item_params
        params[:item].permit(:ytlink)
    end

end
