class SubscriptionsController < ApplicationController
  def create
    @round = Round.find(params[:id])
    authorize! :subscribe_to, @round
    @subscription = current_user.subscriptions.build(:round_id => params[:id])
    
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
    authorize! :unsubscribe_from, @round
    @subscription = current_user.subscriptions.where(:round_id => @round.id).first
    
    @subscription.destroy
    
    flash[:notice] = "You are no longer subscribed to this round."
    redirect_to @round
  end
end
