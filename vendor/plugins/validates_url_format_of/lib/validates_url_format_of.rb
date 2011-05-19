module ValidatesUrlFormatOf
  def validates_url_format_of(*attr_names)
    options = { :allow_nil => false,
                :allow_blank => false,
                :with => /^(#{URI::regexp(%w(http https))})$/ }
                
    options = options.merge(attr_names.pop) if attr_names.last.is_a?(Hash)

    attr_names.each do |attr_name|
      validates_format_of attr_name, options
    end
  end
end

ActiveRecord::Base.extend(ValidatesUrlFormatOf)