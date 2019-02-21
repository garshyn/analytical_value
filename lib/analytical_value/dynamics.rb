module AnalyticalValue
  class Dynamics
    attr_reader :value, :prev
    delegate :positive?, :negative?, :zero?, :abs, to: :difference_signed

    def initialize(prev, value)
      @prev = prev
      @value = value
    end

    def percentage
      return 0 if value.zero? && prev.zero?
      return 100 if prev.zero?

      (difference * 100.0 / prev).round
    end

    def difference_signed
      value - prev
    end

    def ==(other)
      value == other.value && prev == other.prev
    end

    alias increased? positive?
    alias decreased? negative?
    alias stable? zero?
    alias difference abs
  end
end
