class RoundsController < ApplicationController
  before_filter :parse_dates, :only => [:create, :update]
  load_and_authorize_resource

  def index
    @rounds = Round.approved
    @rounds = @rounds.where(:arenas => { :town_woeid => current_location.woeid }).joins(:arena) if located?
    @rounds = @rounds.select("rounds.*, interests_count").
              joins("LEFT OUTER JOIN (" +
                Round.joins(:subscriptions).
                joins("INNER JOIN taggings ON subscriptions.user_id = taggings.taggable_id").
                where("taggings.tag_id IN (SELECT tag_id FROM taggings WHERE taggings.taggable_id = #{current_user.id}) AND taggings.context = 'interests'").
                select("rounds.id AS inner_round_id, COUNT(*) as interests_count").
                group("rounds.id").to_sql +
              ") ON rounds.id = inner_round_id").
              order("interests_count DESC") if signed_in?
              
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
