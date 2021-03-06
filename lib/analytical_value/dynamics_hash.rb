module AnalyticalValue
  class DynamicsHash
    def initialize(prev_hash, current_hash, keys: nil)
      @prev_hash = prev_hash || {}
      @current_hash = current_hash || {}
      @selected_keys = keys || default_keys
    end

    def result
      @_result ||= selected_keys.each_with_object({}) do |key, hash|
        hash[key] = Dynamics.new to_hash[key].first, to_hash[key].last
      end
    end

    def [](key)
      result[key] || empty_dynamics
    end

    def to_hash
      @_hash ||= selected_keys.each_with_object(Hash.new(0)) do |key, hash|
        hash[key] = [
          prev_hash.fetch(key, 0),
          current_hash.fetch(key, 0),
        ]
      end
    end

    protected

    attr_reader :prev_hash, :current_hash, :selected_keys

    def default_keys
      @_default_keys ||= prev_hash.merge(current_hash).keys
    end

    def empty_dynamics
      Dynamics.new 0, 0
    end
  end
end
