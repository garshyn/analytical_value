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

    it 'selects keys' do
      hash_1 = {
        1 => 1,
        2 => 2,
      }
      hash_2 = {
        1 => 3,
        3 => 4,
      }
      hash = described_class.new(
        hash_1,
        hash_2,
        keys: [1, 4],
      )

      dynamics_1 = Dynamics.new(1, 3)
      dynamics_2 = Dynamics.new(0, 0)

      expect(hash[1]).to eq dynamics_1
      expect(hash[2]).to be_empty
      expect(hash[3]).to be_empty
      expect(hash[4]).to eq dynamics_2
      expect(hash.result).to eq(
        1 => dynamics_1,
        4 => dynamics_2,
      )

      expect(hash.to_hash).to eq(
        1 => [1, 3],
        4 => [0, 0],
      )
    end

    it 'handles nil' do
      hash_2 = {
        1 => 3,
        3 => 4,
      }
      hash = described_class.new nil, hash_2

      dynamics_1 = Dynamics.new(0, 3)
      dynamics_2 = Dynamics.new(0, 0)
      dynamics_3 = Dynamics.new(0, 4)

      expect(hash[1]).to eq dynamics_1
      expect(hash[2]).to eq dynamics_2
      expect(hash[3]).to eq dynamics_3
      expect(hash.result).to eq(
        1 => dynamics_1,
        3 => dynamics_3,
      )

      expect(hash.to_hash).to eq(
        1 => [0, 3],
        3 => [0, 4],
      )
    end

    it 'handles nil' do
      hash_1 = {
        1 => 1,
        2 => 2,
      }
      hash = described_class.new hash_1, nil

      dynamics_1 = Dynamics.new(1, 0)
      dynamics_2 = Dynamics.new(2, 0)

      expect(hash[1]).to eq dynamics_1
      expect(hash[2]).to eq dynamics_2
      expect(hash.result).to eq(
        1 => dynamics_1,
        2 => dynamics_2,
      )
    end

    it 'handles nil' do
      hash = described_class.new nil, nil

      dynamics_1 = Dynamics.new(0, 0)

      expect(hash[1]).to eq dynamics_1
      expect(hash[1]).to be_empty
      expect(hash.result).to eq({})
    end
  end
end
