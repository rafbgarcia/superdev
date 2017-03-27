module ItemsHelper

  def relative_time(date)
    has_passed_one_day = 1.day.ago > date

    if has_passed_one_day
      l(date, format: 'dia %d/%m às %H:%M')
    else
      time_ago_in_words date, include_seconds: true
    end
  end

  def format_item_type(type)
    type.underscore.downcase
  end

  def item_path(item)
    course_item_path(
      course_id: item.lesson.course.slug,
      lesson_id: item.lesson.slug,
      item_weight: item.weight
    )
  end

end
