module ApplicationHelper

  def html_text(string)
    simple_format(h(string))
  end

  def anchor_discussion_path(discussion, anchor: true)
    item = discussion.item

    path_params = {
      course_id: item.lesson.course,
      lesson_id: item.lesson,
      item_weight: item.weight,
      discussion_id: discussion,
    }

    path_params[:anchor] = 'posts-list' if anchor

    discussion_url(path_params)
  end

  DATE_FORMATS = {
    dB: '%d de %B',
    dBY: '%d de %B de %Y',
  }.freeze
  def datefy(date, format = :dB)
    l(date, format: DATE_FORMATS[format])
  end

  def display_flash
    html = [:notice, :alert].collect do |key|
      if flash[key]
        class_name = key == :alert ? 'warning' : 'info'
        content_tag(:div, flash[key], class: "alert alert-#{class_name}")
      end
    end

    html.join.html_safe if html.present?
  end

end
