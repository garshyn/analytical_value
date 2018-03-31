module AnalyticalValue
  class Collection
    def initialize(options = {})
      @options = options
      @collection = []
      @values = []
      (options[:values] || []).each do |value|
        add Value.new(value: value)
      end
    end

    def current
      add(@options[:query] || Value.new) if empty?
      @current ||= @collection.first
    end

    def values(count = @values.size)
      if count <= size
        @values[0..count]
      else
        query = @options[:query] || Value.new
        (size..count - 1).each do
          add query
          query = query.prev
        end
        @values[0..count]
      end
    end

    def size
      @collection.size
    end

    def empty?
      @collection.empty?
    end

    def add(value)
      @values << value.value
      if @collection.empty?
        @collection << value
      else
        next_value = @collection.last
        @collection << value
        next_value.prev = value
      end
    end
  end
end
