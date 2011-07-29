class ApprovalsController < ApplicationController
  def create
    @round = Round.find(params[:round_id])
    authorize! :approve, @round
    
    respond_to do |format|
      begin
        @round.approve!
        format.html { redirect_to dashboards_path(current_user), :notice => t('controllers.approve.success') }
        format.json { head :ok }
      rescue StateMachine::InvalidTransition
        format.html { redirect_to dashboards_path(current_user), :notice => t('controllers.approve.failure') }
        format.json { head :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @round = Round.find(params[:round_id])
    authorize! :approve, @round
    
    respond_to do |format|
      if @round.reject!
        format.html { redirect_to dashboards_path(current_user), :notice => t('controllers.reject.success') }
      else
        format.html { redirect_to dashboards_path(current_user), :notice => t('controllers.reject.failure') }
      end
    end
  end
end
