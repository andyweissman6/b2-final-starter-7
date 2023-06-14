class HolidayBuilder
  def self.get_next_holidays
    response = HTTParty.get("")
    parsed = JSON.parse(response.body, symbolize_names: true)
      holidays = parsed.map do |data|
        Holiday.new(data)
      end
    query_date = Date.today
    next_holidays = holidays.select do |holiday|
      holiday_date = Date.parse(holiday.date)
      holiday_date >= query_date
    end
    next_three_days
  end
end