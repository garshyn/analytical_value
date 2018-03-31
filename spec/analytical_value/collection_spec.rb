module AnalyticalValue
  describe Collection do
    let(:subject) { described_class.new(options) }
    let(:options) { {} }
    it { is_expected.to be_empty }

    context "no values" do
      let(:options) { { values: [] } }
      it { is_expected.to be_empty }
      it { expect(subject.current).to be_a(AnalyticalValue::Value)  }
      it { expect(subject.current.value).to eq 0 }
      it { expect(subject.current.prev.value).to eq 0 }
    end

    context "values" do
      let(:options) { { values: [1, 2, 3] } }
      it { expect(subject.current).to be_a(AnalyticalValue::Value)  }
      it { expect(subject.current.value).to eq 1 }
      it { expect(subject.current.prev.value).to eq 2 }
      it { expect(subject.current.prev.prev.value).to eq 3 }
      it { expect(subject.values).to eq [1, 2, 3] }
    end

    context 'querying for values' do
      let(:date) { Time.current.end_of_week }
      let(:range) { 1.week }
      let(:query_options) { { date: date, range: range } }
      let(:options) { { query: SampleQuery.new(query_options) } }
      it { expect(subject.current.value).to eq 5 }
      it { expect(subject.values(3)).to eq [5, 2, 1] }
      it { expect(subject.current.prev.prev.value).to eq 1 }
      context 'with params' do
        let(:query_options) { { date: date, range: range, param_value: 2 } }
        let(:options) { { query: ParamQuery.new(query_options) } }
        it { expect(subject.current.value).to eq 8 }
        it { expect(subject.current.percentage).to eq 33 }
      end
    end
  end
end
