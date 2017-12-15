require 'spec_helper'

describe AnalyticalValue::Value do
  let(:subject) { described_class.new(options) }
  let(:options) { {} }
  it { expect(subject.value).to eq 0 }
  it { expect(subject.percentage).to eq 0 }
  it { is_expected.to be_zero }

  context "provided values" do
    let(:options) { { value: 1, prev: 4 } }
    it { expect(subject.value).to eq 1 }
    it { expect(subject.prev_value).to eq 4 }
    it { expect(subject.difference).to eq 3 }
    it { expect(subject.percentage).to eq 75 }
    it { expect(subject).not_to be_zero }
  end

  context "missed prev value" do
    let(:options) { { value: 1 } }
    it { expect(subject.value).to eq 1 }
    it { expect(subject.prev_value).to eq 0 }
    it { expect(subject.difference).to eq 1 }
    it { expect(subject.percentage).to eq 100 }
    it { expect(subject).not_to be_zero }
  end

  context "before as array" do
    let(:options) { { value: 5, before: [2, 1] } }
    it { expect(subject.value).to eq 5 }
    it { expect(subject.prev_value).to eq 2 }
    it { expect(subject.prev.value).to eq 2 }
    it { expect(subject.prev.prev_value).to eq 1 }
  end

end
