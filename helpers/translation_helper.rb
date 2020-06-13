# frozen_string_literal: true

require 'sinatra/r18n'

module TranslationHelper
  include R18n::Helpers

  def humanize_date(date)
    if date == Date.today
      R18n.t.cv.time.now
    else
      R18n.l(date, '%b %Y')
    end
  end

  def how_long_in_words(years_months)
    years, months = years_months
    how_long = [
      years.positive? ? R18n.t.cv.time.year.count(years) : nil,
      months.positive? ? R18n.t.cv.time.month.count(months) : nil
    ]
    how_long.compact.join(', ')
  end

  def format_date_mdy_ordinalize(date)
    date.strftime("%B #{date.day.ordinalize}, %Y")
  end
end
