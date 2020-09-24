class VotesController < ApplicationController
  before_action :set_vote, only: [:destroy]
  before_action :set_item
  before_action :set_playlist
  before_action :authenticate_user!

  # POST /votes
  # POST /votes.json
  def create
    @vote = current_user.votes.build(vote_params)

    # TODO: Do this within one ActiveRecord transaction; Move to new @item.add_vote method
    respond_to do |format|
      if @vote.save && @item.increment!(:rank)
        format.html { redirect_to @playlist, notice: 'Playlist was successfully created.' }
        format.json { render :show, status: :created, location: @playlist }
      else
        format.html { redirect_to @playlist, notice: 'You have already voted for this item.' }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  # TODO: Do this within one ActiveRecord transaction;  Move to new @item.remove_vote method
  def destroy
    @vote.destroy
    @item.decrement!(:rank)
    respond_to do |format|
      format.html { redirect_to @playlist }
      format.json { head :no_content }
    end
  end

  private

    def set_item
      @item = Item.find(params[:item_id])
    end

    def set_playlist
      @playlist = Playlist.find(params[:playlist_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = current_user.votes.find_by_item_id(params[:item_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      {:item_id => @item.id}
    end
end
