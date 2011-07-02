class SettingsController < ApplicationController
  def update
    allowed_settings = [ :show_quicktour, :current_guider ]
    
    params[:settings].each do |k, v|
      current_user.settings[k] = v if allowed_settings.include? k.to_sym
    end

    respond_to do |format|
      format.json {
        head :ok
      }
    end
  end
end
