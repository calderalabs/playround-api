class ArenasController < ApplicationController
  load_and_authorize_resource :except => [:autocomplete_address]
  before_filter :authorize_autocomplete, :only => [:autocomplete_address]
  
  def index
    @arenas = Arena.where({})
    @arenas = @arenas.available_for(current_user) if signed_in?
    @arenas = @arenas.near(current_location) if located?
    @arenas = @arenas.where('LOWER(name) LIKE LOWER(?)', "#{params[:q]}%") if params[:q]
    
    respond_to do |format|
      format.html
      format.json  { render :json => @arenas }
    end
  end

  def show
    @arena = Arena.find(params[:id])

    respond_to do |format|
      format.html
      format.json  { render :json => @arena }
    end
  end

  def new
    @arena = Arena.new
    
    if located?
      @arena.latitude = @location.latitude
      @arena.longitude = @location.longitude
    end
    
    respond_to do |format|
      format.html
      format.json  { render :json => @arena }
    end
  end

  def edit
    @arena = Arena.find(params[:id])
  end

  def create
    @arena = current_user.arenas.build(params[:arena])

    respond_to do |format|
      if @arena.save
        format.html { redirect_to(@arena, :notice => t('controllers.arenas.create.success')) }
        format.json  { render :json => @arena, :status => :created }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @arena.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @arena = Arena.find(params[:id])

    respond_to do |format|
      if @arena.update_attributes(params[:arena])
        format.html { redirect_to(@arena, :notice => t('controllers.arenas.update.success')) }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @arena.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @arena = Arena.find(params[:id])

    respond_to do |format|
      if @arena.destroy
        format.html { redirect_to(arenas_url, :notice => t('controllers.arenas.delete.success')) }
        format.json { head :ok }
      else
        format.html { redirect_to(@arena, :error => t('controllers.arenas.delete.failure')) }
        format.json { render :json => @arena.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def autocomplete_address
    @locations = Geocoder.search(params[:term]).each_with_index.collect {|l, index| {:id => index, :label => l.address, :value => l.address, :latitude => l.latitude, :longitude => l.longitude}}
    render :json => @locations
  end
  
  private
    
  def authorize_autocomplete
    authorize! :create, Arena
  end
end
