module AnalyticalValue
  class QueryFactory
    def initialize(options)
      @options = options
    end

    def call(query_class)
      query_class.new(@options)
    end
  end
end
