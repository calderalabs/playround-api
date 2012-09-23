module ModelAdditions
  def accessible_attributes
    attributes.select { |k,v| self.class.accessible_attributes.include?(k.to_sym) }
  end
end

ActiveSupport.on_load :active_record do
  include ModelAdditions
end