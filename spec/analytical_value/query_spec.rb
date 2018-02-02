require 'spec_helper'

class AnalyticalValue::SampleQuery < AnalyticalValue::Query
  def query
    {
      Time.current.end_of_week => 5,
      7.days.ago.end_of_week => 2,
      14.days.ago.end_of_week => 1
    }[date]
  end
end

class ParamQuery < AnalyticalValue::Query
  def query
    {
      Time.current.end_of_week => param[:param_value] ** 2 + 10,
      7.days.ago.end_of_week => param[:param_value] ** 2 + 5,
      14.days.ago.end_of_week => param[:param_value] ** 2 + 1
    }[date]
  end
  def param
    @options[:param]
  end
end

describe AnalyticalValue::Query do
  let(:date) { Time.current.end_of_week }
  let(:range) { 1.week }
  let(:prev_date) { date - range }
  let(:prev_prev_date) { prev_date - range }
  let(:options) { { date: date, range: range } }
  it { expect(subject.value).to eq 0 }
  it { is_expected.to be_zero }

  context "querying data" do
    let(:subject) { AnalyticalValue::SampleQuery.new(options) }
    it { expect(subject.date).to eq date }
    it { expect(subject.from).to eq prev_date }
    it { expect(subject.to).to eq (date - 1) }
    it { expect(subject.value).to eq 5 }
    it { expect(subject.prev.date).to eq prev_date }
    it { expect(subject.prev_value).to eq 2 }
    it { expect(subject.prev.value).to eq 2 }
    it { expect(subject.prev.prev_value).to eq 1 }
    it { expect(subject.prev.prev.value).to eq 1 }
  end
  context "querying data with parameters" do
    it do
      paramObjects = [
        { id: 1, param_value: 1 },
        { id: 2, param_value: 2 },
        { id: 3, param_value: 4 },
        { id: 4, param_value: 6 }
      ]
      queries = []
      paramObjects.each do |obj|
        query = ParamQuery.new(options.merge(param: obj))
        # puts "#{obj[:id]}: #{query.prev.prev_value} -> #{query.prev.value} -> #{query.value}: #{query.percentage}%"
        queries << query
      end
      expect(queries.last.call).to eq 46
      expect(queries.last.prev.value).to eq 41
    end
  end
end
