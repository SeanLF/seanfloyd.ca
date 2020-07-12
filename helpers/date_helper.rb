# frozen_string_literal: true

##
# Helper for formatting dates in CVs

module DateHelper
  DAYS_IN_MONTH = 30
  MONTHS_IN_YEAR = 12

  def parse_date(date)
    if date == 'now'
      Date.today
    else
      Date.parse(date)
    end
  end

  def format_date_ymd(date)
    date = parse_date(date) if date.is_a? String
    date.strftime('%Y-%m-%d')
  end

  ##
  # Gets the number of years and months between two dates.
  # :args: start_date, end_date
  # :yields: years, months

  def how_long(start_date, end_date)
    distance_in_days = date_diff(start_date, end_date)
    return [0, 0] unless distance_in_days.positive?

    months, distance_in_days = distance_in_days.divmod(DAYS_IN_MONTH)
    months += 1 if (distance_in_days / DAYS_IN_MONTH.to_f).round.positive?
    months.divmod(MONTHS_IN_YEAR)
  end

  private

  def date_diff(start_date, end_date)
    start_date = parse_date(start_date) if start_date.is_a? String
    end_date = parse_date(end_date) if end_date.is_a? String
    end_date - start_date
  end
end
