class SubscriptionsController < ApplicationController
  before_action :set_playlist
  before_action :set_subscription, only: [:destroy]
  before_action :authenticate_user!

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = current_user.subscriptions.create(subscription_params)
    redirect_to @playlist
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: 'Subscription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_playlist
      @playlist = Playlist.find(params[:playlist_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      {:playlist_id => @playlist.id}
    end
end
