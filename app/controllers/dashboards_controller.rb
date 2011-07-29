class DashboardsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    
    authorize! :update, @user
    
    @arenas = @user.arenas
    @rounds = Round.where(:arena_id => @arenas.map { |a| a.id })

    respond_to do |format|
      format.html
    end
  end
end
