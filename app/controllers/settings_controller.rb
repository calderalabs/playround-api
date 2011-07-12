class SettingsController < ApplicationController
  def update
    allowed_settings = [ :show_quicktour, :current_guider ]
    
    params[:settings].each do |k, v|
      current_user.send("#{k}=", v) if allowed_settings.include? k.to_sym
    end

    respond_to do |format|
      if current_user.save
        format.json { head :ok }
      else
        format.json  { render :json => current_user.errors, :status => :unprocessable_entity }
      end
    end
  end
end
