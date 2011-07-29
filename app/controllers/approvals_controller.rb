class ApprovalsController < ApplicationController
  def create
    @round = Round.find(params[:round_id])
    authorize! :approve, @round
    
    respond_to do |format|
      begin
        @round.approve!
        format.html { redirect_to dashboards_path(current_user), :notice => 'Round was successfully approved.' }
        format.json { head :ok }
      rescue StateMachine::InvalidTransition
        format.html { redirect_to dashboards_path(current_user), :notice => 'Unable to approve round.' }
        format.json { head :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @round = Round.find(params[:round_id])
    authorize! :approve, @round
    
    respond_to do |format|
      if @round.reject!
        format.html { redirect_to dashboards_path(current_user), :notice => 'Round was successfully rejected.' }
      else
        format.html { redirect_to dashboards_path(current_user), :notice => 'Unable to reject round.' }
      end
    end
  end
end
