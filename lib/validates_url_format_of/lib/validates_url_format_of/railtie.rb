module ValidatesUrlFormatOf
  class Railtie < Rails::Railtie
    initializer 'validates_url_format_of.model_additions' do
      ActiveSupport.on_load :active_record do
        extend ModelAdditions
      end
    end
  end
end