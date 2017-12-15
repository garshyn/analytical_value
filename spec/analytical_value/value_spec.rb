require 'spec_helper'

describe AnalyticalValue::Value do
  let(:subject) { described_class.new(options) }
  let(:options) { {} }
  it { expect(subject.value).to eq 0 }

  context "provided values" do
    let(:options) { { value: 1, prev: 4 } }
    it { expect(subject.value).to eq 1 }
  end

end
