class ConfirmationController < ApplicationController
  def create
    @round = Round.find(params[:round_id])
    authorize! :confirm, @round
    
    respond_to do |format|
      if @round.confirm!
        format.html { redirect_to(@round, :notice => 'Round was successfully confirmed.') }
        format.json { head :ok }
      else
        format.html { redirect_to @round }
        format.json { render :json => @round.errors, :status => :unprocessable_entity }
      end
    end
  end
end
