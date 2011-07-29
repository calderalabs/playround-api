class SubscriptionsController < ApplicationController
  def create
    @round = Round.find(params[:round_id])

    authorize! :create, Subscription
    
    respond_to do |format|
      if current_user.subscriptions.create(:round_id => @round.id)
        format.html { redirect_to @round, :notice => t('controllers.subscriptions.create.success') }
      else
        format.html { redirect_to @round, :error => t('controllers.subscriptions.create.failure') }
      end
    end
  end
  
  def destroy
    @round = Round.find(params[:round_id])

    authorize! :create, Subscription
    authorize! :destroy, @round.subscription_for(current_user)
    
    respond_to do |format|
      if @round.subscription_for(current_user).try(:destroy)
        format.html { redirect_to @round, :notice => t('controllers.subscriptions.delete.success') }
      else
        format.html { redirect_to @round, :notice => t('controllers.subscriptions.delete.failure') }
      end
    end
  end
end
