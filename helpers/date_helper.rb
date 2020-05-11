require 'sinatra/r18n'
include R18n::Helpers

module DateHelper
  def format_date_ymd(date)
    date.strftime('%Y-%m-%d')
  end
  
  def parse_date(date)
    if date === 'now'
      Date.today
    else
      Date.parse(date)
    end
  end
  
  def humanize_date(date)
    if date === 'now'
      R18n.t.cv.time.now
    else
      R18n.l(Date.parse(date), format='%b %Y')
    end
  end
  
  def how_long(start_date, end_date)
    distance_in_days = (parse_date(end_date) - parse_date(start_date)).to_f
    how_long_in_words(distance_in_days)
  end
  
  # x month(s) OR x year(s) OR x year(s), x month(s)
  def how_long_in_words(distance_in_days)
    _DAYS_IN_YEAR = 365
    distance_in_months = distance_in_months(distance_in_days)
    if distance_in_months < 1
      ''
    elsif (distance_in_months < 12)
      R18n.t.cv.time.month.count(distance_in_months)
    else
      years = (distance_in_days / _DAYS_IN_YEAR).round
      distance_in_days -= years * _DAYS_IN_YEAR
      length = R18n.t.cv.time.year.count(years)
      months = how_long_in_words(distance_in_days)
      if months.empty?
        return length
      end
      length << ', ' << months
    end
  end
  
  def distance_in_months(distance_in_days)
    _DAYS_IN_MONTH = 30
    (distance_in_days / _DAYS_IN_MONTH).round
  end
  
  def format_date_mdy_ordinalize(date)
    date.strftime("%B #{date.day.ordinalize}, %Y")
  end
end