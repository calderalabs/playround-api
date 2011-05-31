class SubscriptionsController < ApplicationController
  def create
    @subscription = current_user.subscriptions.build(:round_id => params[:id])
    @round = Round.find(params[:id])
    authorize! :manage_subscription_of, @round
    
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
    authorize! :manage_subscription_of, @round
    @subscription.destroy
    
    flash[:notice] = "You are no longer subscribed to this round."
    redirect_to @round
  end
end
