class RoundsController < ApplicationController
  before_filter :parse_dates, :only => [:create, :update]
  load_and_authorize_resource

  def index
    @rounds = @rounds.where(:arenas => { :town_woeid => current_location.woeid }).joins(:arena) if located?
    
    respond_to do |format|
      format.html
      format.json  { render :json => @rounds }
    end
  end

  def show
    @comment = @round.comments.build
    @comment.user = current_user
    
    respond_to do |format|
      format.html
      format.json  { render :json => @round }
    end
  end

  def new
    respond_to do |format|
      format.html
      format.json  { render :json => @round }
    end
  end

  def edit

  end

  def create
    @round.user = current_user
    
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
    respond_to do |format|
      if @round.destroy
        format.html { redirect_to(rounds_url, :notice => 'Round was succesfully deleted.') }
        format.json  { head :ok }
      else
        format.html { redirect_to(@round, :error => 'Unable to delete this round.') }
        format.json  { render :json => @round.errors, :status => :unprocessable_entity }
      end
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
