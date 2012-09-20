module AdjustString
  module ModelAdditions
    def adjusts_string(*attr_names)
      options = { :prepend => nil,
                  :append => nil,
                  :case => nil,
                  :if => nil,
                  :unless_blank => true }
                  
      options = options.merge(attr_names.pop) if attr_names.last.is_a?(Hash)

      before_validation :if => options[:if] do
        attr_names.each do |attr_name|
          if !options[:unless_blank] || !self.send(attr_name).blank?
            self.send("#{attr_name}=", options[:prepend] + self.send(attr_name)) unless options[:prepend].nil?
            self.send("#{attr_name}=", self.send(attr_name) + options[:append]) unless options[:append].nil?
          
            case options[:case]
              when :capitalize 
                self.send("#{attr_name}").capitalize!
              when :upcase 
                self.send("#{attr_name}").upcase!
              when :downcase 
                self.send("#{attr_name}").downcase!
            end
          end
        end
      end
    end
  end
end