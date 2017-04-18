module ItemsHelper

  def format_item_type(type)
    type.underscore.downcase
  end

  def item_icon(item)
    if item.video? && item.itemable.url.blank?
      if item.itemable.exercise?
        icon('list-ol')
      else
        icon('file-text', style: 'margin-left: 2px')
      end
    else
      image_tag "question_type_#{format_item_type(item.type)}.png"
    end
  end

  def item_path(item)
    course_item_path(
      course_id: item.lesson.course.slug,
      lesson_id: item.lesson.slug,
      item_weight: item.weight
    )
  end

end
