class DashboardsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    
    authorize! :update, @user
    
    @arenas = @user.arenas
    @prending_rounds = Round.where(:arena_id => @arenas.map { |a| a.id }).pending_approval
    @approved_rounds = Round.where(:arena_id => @arenas.map { |a| a.id }).approved
    
    respond_to do |format|
      format.html
    end
  end
end
