class GamesController < ApplicationController
  load_and_authorize_resource

  def index
    @games = Game.where({})
    @games = @games.where('LOWER(name) LIKE LOWER(?)', "#{params[:q]}%") if params[:q]
    
    respond_to do |format|
      format.html
      format.json  { render :json => @games }
    end
  end

  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html
      format.json  { render :json => @game }
    end
  end

  def new
    @game = Game.new

    respond_to do |format|
      format.html
      format.json  { render :json => @game }
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def create
    @game = current_user.games.build(params[:game])

    respond_to do |format|
      if @game.save
        format.html { redirect_to(@game, :notice => t('controllers.games.create.success')) }
        format.json  { render :json => @game, :status => :created }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @game.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @game = Game.find(params[:id])
    
    respond_to do |format|
      if @game.destroy
        format.html { redirect_to(games_url, :notice => t('controllers.games.delete.success')) }
        format.json { head :ok }
      else
        format.html { redirect_to(@game, :error => t('controllers.games.delete.failure')) }
        format.json { render :json => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to(@game, :notice => t('controllers.games.update.success')) }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @game.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private
    
  def authorize_autocomplete
    authorize! :create, Game
  end
  
end
