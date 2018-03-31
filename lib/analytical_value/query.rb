module AnalyticalValue
  class Query < Value
    def date
      @options[:date]
    end

    def range
      @options[:range]
    end

    def from
      date - range
    end

    def to
      date - 1
    end

    def value
      @value ||= query
    end

    def prev
      @options[:prev] ||= self.class.new @options.merge(date: date - range)
    end

    def call
      @value = query
    end

    private

    def query
      0
    end
  end
end
