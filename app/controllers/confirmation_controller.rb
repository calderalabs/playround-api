class ConfirmationController < ApplicationController
  def create
    @round = Round.find(params[:round_id])
    authorize! :manage_confirmation_of, @round
    
    respond_to do |format|
      if @round.confirm!
        format.html { redirect_to(@round, :notice => 'Round was successfully confirmed.') }
        format.xml { head :ok }
      else
        format.html { redirect_to @round }
        format.xml { render :xml => @round.errors, :status => :unprocessable_entity }
      end
    end
  end
end
