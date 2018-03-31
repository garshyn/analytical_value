describe AnalyticalValue::Value do
  let(:subject) { described_class.new(options) }
  let(:options) { {} }
  it { expect(subject.value).to eq 0 }
  it { expect(subject.percentage).to eq 0 }
  it { is_expected.to be_zero }

  context "provided values" do
    let(:options) { { value: 1, prev_value: 4 } }
    it { expect(subject.value).to eq 1 }
    it { expect(subject.prev_value).to eq 4 }
    it { is_expected.to be_decreased }
    it { expect(subject.difference).to eq 3 }
    it { expect(subject.percentage).to eq 75 }
    it { expect(subject).not_to be_zero }
  end

  context "missed prev value" do
    let(:options) { { value: 1 } }
    it { expect(subject.value).to eq 1 }
    it { expect(subject.prev_value).to eq 0 }
    it { is_expected.to be_increased }
    it { expect(subject.difference).to eq 1 }
    it { expect(subject.percentage).to eq 100 }
    it { expect(subject).not_to be_zero }
    context "connecting prev value" do
      before :each do
        subject.prev = described_class.new(value: 2)
      end
      it { expect(subject.prev_value).to eq 2 }
      it { is_expected.to be_decreased }
      it { expect(subject.difference).to eq 1 }
      it { expect(subject.percentage).to eq 50 }
    end
  end
end
