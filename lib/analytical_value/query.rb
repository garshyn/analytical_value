module AnalyticalValue
  class Query < Value

    def date
      @options[:date]
    end

    def range
      @options[:range]
    end

    def value
      @value ||= @options[:value] || query
    end

    private
    def query
      0
    end
    def options_for_before_object(index)
      super.tap do |options|
        options[:date] = date - range
      end
    end
  end
end
