require 'spec_helper'

describe AnalyticalValue::Collection do
  let(:subject) { described_class.new(options) }
  let(:options) { {} }
  it { is_expected.to be_empty }

  context "no values" do
    let(:options) { { values: [] } }
    it { is_expected.to be_empty }
    it { expect(subject.current).to be_a(AnalyticalValue::Value)  }
    it { expect(subject.current.value).to eq 0 }
  end

  context "values" do
    let(:options) { { values: [1, 2, 3] } }
    it { expect(subject.current).to be_a(AnalyticalValue::Value)  }
    it { expect(subject.current.value).to eq 3 }
  end

end
