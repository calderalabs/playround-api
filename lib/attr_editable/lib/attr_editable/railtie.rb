module AttrEditable
  class Railtie < Rails::Railtie
    initializer 'attr_editable.model_additions' do
      ActiveSupport.on_load :active_record do
        extend ModelAdditions
      end
    end
  end
end