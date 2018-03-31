class AnalyticalValue::SampleQuery < AnalyticalValue::Query
  def query
    {
      Time.current.end_of_week => 5,
      1.week.ago.end_of_week => 2,
      2.weeks.ago.end_of_week => 1,
      3.weeks.ago.end_of_week => 10,
    }[date]
  end
end
