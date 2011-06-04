class PagesController < ApplicationController
  def index
    redirect_to rounds_path if signed_in?
    
    @user = User.new
  end
end
