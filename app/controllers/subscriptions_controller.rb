class SubscriptionsController < ApplicationController
  load_and_authorize_resource
  
  def create
    @subscription = current_user.subscriptions.build(:round_id => params[:id])
    @round = Round.find(params[:id])
    
    if @subscription.save
      flash[:notice] = "You successfully subscribed to this round."
      redirect_to @round
    else
      flash[:failure] = "An error occurred while subscribing to this round."
      redirect_to @round
    end
  end
  
  def destroy
    @round = Round.find(params[:id])
    @subscription = current_user.subscriptions.where(:round_id => @round.id).first
    @subscription.destroy
    
    flash[:notice] = "You are no longer subscribed to this round."
    redirect_to @subscription.round
  end
end
