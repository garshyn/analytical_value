module AnalyticalValue
  class Value

    def initialize(options = {})
      @options = options
    end


    def value
      @options[:value] ||= query
    end

    private
    def query
      0
    end
  end
end
