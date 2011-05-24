class SubscriptionsController < ApplicationController
  def create
    @subscription = current_user.subscriptions.build(:round_id => params[:id])
    @round = Round.find(params[:id])
    
    if @subscription.save
      flash[:notice] = "You successfully subscribed to this round"
      redirect_to @round
    else
      flash[:error] = "You are already subscribed to this round"
      redirect_to @round
    end
  end
  
  def destroy
    @round = Round.find(params[:id])
    @subscription = current_user.subscriptions.where(:round_id => @round.id).first
    @subscription.destroy
    
    flash[:notice] = "Removed subscription."
    redirect_to @subscription.round
  end
end
