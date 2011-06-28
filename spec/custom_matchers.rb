module CustomMatcher
  class OneMoreThan
    def initialize(expected)
      @expected = expected
    end

    def matches?(actual)
      @actual = actual
      @actual == @expected + 1
    end

    def failure_message_for_should
      "expected #{@actual.inspect} to be one more than #{@expected.inspect}, but it wasn't"
    end

    def failure_message_for_should_not
      "expected #{@actual.inspect} not to be one more than #{@expected.inspect}, but it was"
    end
  end

  def be_one_more_than(expected)
    OneMoreThan.new(expected)
  end
  
  class OneLessThan
    def initialize(expected)
      @expected = expected
    end

    def matches?(actual)
      @actual = actual
      @actual == @expected - 1
    end

    def failure_message_for_should
      "expected #{@actual.inspect} to be one less than #{@expected.inspect}, but it wasn't"
    end

    def failure_message_for_should_not
      "expected #{@actual.inspect} not to be one less than #{@expected.inspect}, but it was"
    end
  end

  def be_one_less_than(expected)
    OneLessThan.new(expected)
  end
end