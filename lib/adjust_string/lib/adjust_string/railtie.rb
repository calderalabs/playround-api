module AdjustString
  class Railtie < Rails::Railtie
    initializer 'adjust_string.model_additions' do
      ActiveSupport.on_load :active_record do
        extend ModelAdditions
      end
    end
  end
end