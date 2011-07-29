class ConfirmationsController < ApplicationController
  def create
    @round = Round.find(params[:round_id])
    authorize! :confirm, @round
    
    respond_to do |format|
      begin
        @round.confirm!
        format.html { redirect_to(@round, :notice => t('controllers.confirmations.create.success')) }
        format.json { head :ok }
      rescue StateMachine::InvalidTransition
        format.html { redirect_to(@round, :notice => t('controllers.confirmations.create.failure')) }
        format.json { head :unprocessable_entity }
      end
    end
  end
end
