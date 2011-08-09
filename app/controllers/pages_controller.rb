class PagesController < ApplicationController
  layout "base"
  
  def index
    redirect_to rounds_path if signed_in?
    
    @user = User.new
  end
end
