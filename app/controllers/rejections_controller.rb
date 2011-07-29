class RejectionsController < ApplicationController
  def create
    @round = Round.find(params[:round_id])
    authorize! :reject, @round
    
    respond_to do |format|
      begin
        @round.reject!
        format.html { redirect_to dashboards_path(current_user), :notice => 'Round was successfully rejected.' }
        format.json { head :ok }
      rescue StateMachine::InvalidTransition
        format.html { redirect_to dashboards_path(current_user), :notice => 'Unable to reject round.' }
        format.json { head :unprocessable_entity }
      end
    end
  end
end
