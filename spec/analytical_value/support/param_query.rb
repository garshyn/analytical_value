class ParamQuery < AnalyticalValue::Query
  def query
    {
      Time.current.end_of_week => param * 4,
      1.week.ago.end_of_week => param * 3,
      2.weeks.ago.end_of_week => param * 2,
      3.weeks.ago.end_of_week => param * 1,
    }[date]
  end

  def param
    @options[:param_value]
  end
end
