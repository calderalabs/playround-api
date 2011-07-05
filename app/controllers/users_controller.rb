class UsersController < Clearance::UsersController
  load_and_authorize_resource
  before_filter :parse_settings, :only => [:create, :update]
  
  def index
    @users = User.all
    
    respond_to do |format|
      format.html
      format.json  { render :json => @users }
    end
  end  
  
  def show
    @user = User.find(params[:id])
    
    respond_to do |format|
      format.html
      format.json  { render :json => @user }
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'Your profile was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private

  def parse_settings
    unless params[:user].nil?
      params[:user][:show_email] = params[:user][:show_email].to_b
    end
  end

  def flash_notice_after_create
    
  end
  
  def url_after_create
    rounds_path
  end
end
