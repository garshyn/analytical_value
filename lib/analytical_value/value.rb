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

    def values_before
      @options[:before] ||= []
    end

    def prev_value
      @options[:prev] ||= prev.value
    end

    def prev
      before.first
    end

    def before
      [self.class.new(options_for_before_object(0))]
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

    private
    def options_for_before_object(index)
      @options.clone.tap do |options|
        options[:value] = values_before.size > index ? values_before[index] : nil
        options[:prev] = values_before.size > (index + 1) ? values_before[index + 1] : nil
      end
    end

  end
end
