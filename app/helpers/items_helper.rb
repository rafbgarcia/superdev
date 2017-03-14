module ItemsHelper

  def relative_time(date)
    has_passed_one_day = 1.day.ago > date

    if has_passed_one_day
      date.strftime('dia %d/%m às %H:%M')
    else
      time_ago_in_words date, include_seconds: true
    end
  end

  def format_item_type(type)
    type.underscore.downcase
  end

end
