module AnalyticalValue
  class Collection
    def initialize(options = {})
      @options = options
    end

    def current
      @current ||= Value.new value: values.last
    end

    def values
      @values ||= @options[:values] || []
    end

    def empty?
      values.empty?
    end
  end
end
