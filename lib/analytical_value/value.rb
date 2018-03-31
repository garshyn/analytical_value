module AnalyticalValue
  class Value
    def initialize(options = {})
      @options = options
    end

    def zero?
      value.zero?
    end

    def value
      @value ||= @options[:value] || 0
    end

    def prev_value
      @options[:prev_value] ||= prev.value
    end

    def prev
      @options[:prev] ||= Value.new
    end

    def prev=(prev)
      @options[:prev] = prev
    end

    def difference
      difference_signed.abs
    end

    def difference_signed
      value - prev_value
    end

    def increased?
      difference_signed > 0
    end

    def decreased?
      difference_signed < 0
    end

    def percentage
      if prev_value.zero?
        return 0 if value.zero?
        return 100
      end
      (difference * 100.0 / prev_value).round
    end
  end
end
