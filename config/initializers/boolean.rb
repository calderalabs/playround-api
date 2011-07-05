class String
  def to_b
    case self
      when "1", "yes", "true"
        true
      when "0", "no", "false"
        false
    end
  end
end