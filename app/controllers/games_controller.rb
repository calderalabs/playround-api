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
        format.html { redirect_to(@game, :notice => 'Game was successfully created.') }
        format.json  { render :json => @game, :status => :created }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @game.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to(games_url) }
      format.json  { head :ok }
    end
  end

  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to(@game, :notice => 'Game was successfully updated.') }
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
