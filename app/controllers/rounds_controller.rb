class RoundsController < ApplicationController
  before_filter :parse_dates, :only => [:create, :update]
  load_and_authorize_resource

  def index
    if located?
      @rounds = Round.where(:arenas => { :town_woeid => current_location.woeid }).joins(:arena)
    else
      @rounds = []
    end
    
    respond_to do |format|
      format.html
      format.json  { render :json => @rounds }
    end
  end

  def show
    @round = Round.find(params[:id])
    @comment = Comment.new(:round_id => @round.id)
    
    respond_to do |format|
      format.html
      format.json  { render :json => @round }
    end
  end

  def new
    @round = Round.new

    respond_to do |format|
      format.html
      format.json  { render :json => @round }
    end
  end

  def edit
    @round = Round.find(params[:id])
  end

  def create
    @round = current_user.rounds.build(params[:round])
    
    respond_to do |format|
      if @round.save
        format.html { redirect_to(@round, :notice => 'Round was successfully created.') }
        format.json  { render :json => @round, :status => :created }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @round.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @round = Round.find(params[:id])

    respond_to do |format|
      if @round.update_attributes(params[:round])
        format.html { redirect_to(@round, :notice => 'Round was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @round.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @round = Round.find(params[:id])
    @round.destroy

    respond_to do |format|
      format.html { redirect_to(rounds_url) }
      format.json  { head :ok }
    end
  end
  
  private
  
  def parse_dates
    unless params[:round].nil?
      params[:round][:date] = Time.zone.parse(params[:round][:date]) if params[:round][:date].is_a? String
      params[:round][:deadline] = Time.zone.parse(params[:round][:deadline]) if params[:round][:deadline].is_a? String
    end
  end
end
