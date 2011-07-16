class UsersController < Clearance::UsersController
  load_and_authorize_resource

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
  
  def create
     @user = ::User.new(params[:user])

     if @user.save
       @user.create_quicktour
       
       sign_in(@user)
       redirect_back_or(url_after_create)
     else
       flash_failure_after_create
       render :template => 'users/new'
     end
   end
  
  private

  def flash_notice_after_create
    
  end
  
  def url_after_create
    rounds_path
  end
end
