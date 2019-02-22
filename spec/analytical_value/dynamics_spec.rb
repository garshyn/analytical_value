module AnalyticalValue
  RSpec.describe Dynamics do
    describe '#difference' do
      it 'returns difference between numbers' do
        dynamics = described_class.new 1, 2

        expect(dynamics.difference).to eq 1
        expect(dynamics).to be_increased
      end

      it 'skips negative' do
        dynamics = described_class.new 2, 1

        expect(dynamics.difference).to eq 1
        expect(dynamics).to be_decreased
      end

      it 'is stable' do
        dynamics = described_class.new 1, 1

        expect(dynamics.difference).to eq 0
        expect(dynamics).to be_stable
      end

      it 'is empty' do
        dynamics = described_class.new 0, 0

        expect(dynamics).to be_empty
      end

      it 'handles nil prev' do
        dynamics = described_class.new nil, 1

        expect(dynamics.value).to eq 1
        expect(dynamics.prev).to be_nil
        expect(dynamics).to be_undefined
        expect(dynamics).to be_positive
        expect(dynamics.percentage).to be_nil
        expect(dynamics.difference).to eq 1
      end

      it 'handles nil current' do
        dynamics = described_class.new 1, nil

        expect(dynamics.value).to be_nil
        expect(dynamics.prev).to eq 1
        expect(dynamics).to be_undefined
        expect(dynamics).to be_negative
        expect(dynamics.percentage).to be_nil
        expect(dynamics.difference).to eq 1
      end

      it 'handles both nil values' do
        dynamics = described_class.new nil, nil

        expect(dynamics.value).to be_nil
        expect(dynamics.prev).to be_nil
        expect(dynamics).to be_undefined
        expect(dynamics).to be_stable
        expect(dynamics.percentage).to be_nil
        expect(dynamics.difference).to eq 0
      end
    end

    describe '#percentage' do
      it 'returns percentage' do
        dynamics = described_class.new 1, 2

        expect(dynamics.percentage).to eq 100
      end

      it 'skips negative' do
        dynamics = described_class.new 2, 1

        expect(dynamics.percentage).to eq 50
      end

      it 'handles division by zero' do
        dynamics = described_class.new 0, 1

        expect(dynamics.percentage).to eq 100
      end

      it 'handles zero' do
        dynamics = described_class.new 0, 0

        expect(dynamics.percentage).to eq 0
      end

      it 'handles drop to zer0' do
        dynamics = described_class.new 1, 0

        expect(dynamics.percentage).to eq 100
      end
    end

    describe 'equality' do
      it 'supports comparing objects' do
        dynamics_1 = described_class.new 1, 2
        dynamics_2 = described_class.new 1, 2

        expect(dynamics_1).to eq dynamics_2
      end

      it 'is not equal' do
        dynamics_1 = described_class.new 1, 2
        dynamics_2 = described_class.new 1, 3

        expect(dynamics_1).not_to eq dynamics_2
      end

      it 'is not equal' do
        dynamics_1 = described_class.new 0, 2
        dynamics_2 = described_class.new 1, 2

        expect(dynamics_1).not_to eq dynamics_2
      end
    end
  end
end
