module AnalyticalValue
  RSpec.describe DynamicsHash do
    it 'groups two hashes into a hash of dynamics' do
      hash_1 = {
        1 => 1,
        2 => 2,
      }
      hash_2 = {
        1 => 3,
        3 => 4,
      }
      hash = described_class.new hash_1, hash_2

      dynamics_1 = Dynamics.new(1, 3)
      dynamics_2 = Dynamics.new(2, 0)
      dynamics_3 = Dynamics.new(0, 4)

      expect(hash[1]).to eq dynamics_1
      expect(hash[2]).to eq dynamics_2
      expect(hash[3]).to eq dynamics_3
      expect(hash.result).to eq(
        1 => dynamics_1,
        2 => dynamics_2,
        3 => dynamics_3,
      )

      expect(hash.to_hash).to eq(
        1 => [1, 3],
        2 => [2, 0],
        3 => [0, 4],
      )
    end
  end
end
