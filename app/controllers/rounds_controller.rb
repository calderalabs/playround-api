class RoundsController < ApplicationController
  before_filter :parse_dates, :only => [:create, :update]
  load_and_authorize_resource

  def index
    @rounds = Round.approved.where(:arenas => { :town_woeid => current_location.woeid }).joins(:arena) if located?
    @rounds = @rounds.find_by_sql("SELECT * FROM rounds INNER JOIN subscriptions ON rounds.id = subscriptions.round_id 
                                                        INNER JOIN taggings ON taggings.taggable_id = subscriptions.user_id AND taggings.tag_id IN 
                                                        (SELECT tag_id FROM taggings WHERE taggable_id = #{current_user.id})")
    
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
        format.html { redirect_to(@round, :notice => t('controllers.rounds.create.success')) }
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
        format.html { redirect_to(@round, :notice => t('controllers.rounds.update.success')) }
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
        format.html { redirect_to(rounds_url, :notice => t('controllers.rounds.delete.success')) }
        format.json  { head :ok }
      else
        format.html { redirect_to(@round, :error => t('controllers.rounds.delete.failure')) }
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
