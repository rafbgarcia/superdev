module ApplicationHelper

  def anchor_discussion_path(discussion)
    item = discussion.item

    discussion_url(
      course_id: item.lesson.course,
      lesson_id: item.lesson,
      item_weight: item.weight,
      discussion_id: discussion,
      anchor: 'posts-list'
    )
  end

  DATE_FORMATS = {
    dB: '%d de %B',
    dBY: '%d de %B de %Y',
  }.freeze
  def datefy(date, format = :dB)
    l(date, format: DATE_FORMATS[format])
  end

  def display_flash(*keys)
    keys = keys.empty? ? [:notice, :alert, :success, :error] : keys

    html = keys.collect do |key|
      if flash[key]
        if key == :alert
          k = 'warning'
        elsif key == :notice
          k = 'info'
        else
          k = key
        end

        content_tag(:div, flash[key], :class => "alert alert-#{k}")
      end
    end

    html.join.html_safe if html.present?
  end

end
