class DashboardController < ApplicationController
  def index
    @user = User.find(params[:id])
    
    authorize! :update, @user
    
    @arenas = @user.arenas
    @rounds = Round.where(:arena_id => @arenas.map { |a| a.id }).pending_approval
    
    respond_to do |format|
      format.html { render 'dashboard' }
    end
  end
end
