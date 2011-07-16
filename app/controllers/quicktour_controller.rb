class QuicktourController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :quicktour, :through => :user, :singleton => true
  
  def update
    respond_to do |format|
      if @quicktour.next!
        format.json { head :ok }
      else
        format.json  { render :json => @quicktour.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    respond_to do |format|
      @quicktour.destroy
      
      format.json { head :ok }
    end
  end
end
