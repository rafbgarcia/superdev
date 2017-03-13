module ItemsHelper

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
