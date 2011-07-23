class Object
  def self.with_constants(constants, &block)
    old_constants = Hash.new
    constants.each do |constant, val|
      old_constants[constant] = const_get(constant)
      silence_stderr{ const_set(constant, val) }
    end

    block.call

    old_constants.each do |constant, val|
      silence_stderr{ const_set(constant, val) }
    end
  end
end