module AnalyticalValue
  class Dynamics
    attr_reader :value, :prev
    delegate :positive?, :negative?, :zero?, :abs, to: :difference_signed

    def initialize(prev, value)
      @prev = prev
      @value = value
    end

    def percentage
      return nil if undefined?
      return 0 if empty?
      return 100 if prev.zero?

      (difference * 100.0 / prev).round
    end

    def difference_signed
      value.to_i - prev.to_i
    end

    def ==(other)
      value == other.value && prev == other.prev
    end

    def undefined?
      value.nil? || prev.nil?
    end

    def empty?
      value.zero? && prev.zero?
    end

    def to_s
      return 'undefined' if undefined?
      return 'empty' if empty?
      return 'up' if positive?
      return 'down' if negative?
      return 'stable' if stable?

      ''
    end

    alias increased? positive?
    alias decreased? negative?
    alias stable? zero?
    alias difference abs
  end
end
