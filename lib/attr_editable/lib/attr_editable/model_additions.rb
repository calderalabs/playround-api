module AttrEditable
  module ModelAdditions
    def attr_editable(*attr_names)
      options = { :message => 'cannot be changed after creation' }
                  
      options = options.merge(attr_names.pop) if attr_names.last.is_a?(Hash)

      validate :on => :update do
        changed_attributes.each do |attribute, value|
          errors.add(attribute.to_sym, options[:message]) if !attr_names.include?(attribute.to_sym)
        end
      end
    end
  end
end