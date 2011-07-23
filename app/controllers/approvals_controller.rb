class ApprovalsController < ApplicationController
  def create
    @round = Round.find(params[:round_id])
    authorize! :approve, @round
    
    respond_to do |format|
      if @round.approve!
        format.html { redirect_to dashboards_path(current_user), :notice => 'Round was successfully approved.' }
      else
        format.html { redirect_to dashboards_path(current_user), :notice => 'Unable to approve round.' }
      end
    end
  end
end
