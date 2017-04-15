module ApplicationHelper

  def subscribe_step_1_path
    'http://partiu-codar.superdev.academy/'
  end

  def title(title)
    content_for(:page_title) { title }
  end

  def seo_description(text)
    content_for(:seo_description) { text }
  end

  def render_md(markdown)
    return if markdown.blank?

    extensions = { fenced_code_blocks: true, strikethrough: true, tables: true, autolink: true }
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, link_attributes: { target: '_blank' })#, escape_html: true )
    html = Redcarpet::Markdown.new(renderer, extensions).render(markdown)

    escape_tags = %w(style script)
    escape_tags.each do |tag|
      html = html.gsub("<#{tag}", "&lt;#{tag}")
      html = html.gsub("</#{tag}", "&lt;/#{tag}")
    end
    html.html_safe
  end

  def relative_time(date)
    return if date.blank?
    has_passed_one_day = 1.day.ago > date

    if has_passed_one_day
      l(date, format: 'dia %d/%m às %H:%M')
    else
      time_ago_in_words date, include_seconds: true
    end
  end

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
    date_time: '%d de %B às %H:%i:%m',
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

  def active_link_to(*args)
    path = args.second.is_a?(Hash) ? args.first : args.second
    block = -> { yield } if block_given?
    exact_match = args.last.fetch(:exact_match, false)

    if exact_match
      if path == request.path
        args.last[:class] ||= ''
        args.last[:class] += ' active'

        link_to *args, &block
      else
        link_to *args, &block
      end
    else
      if path.in?(request.path)
        args.last[:class] ||= ''
        args.last[:class] += ' active'

        link_to *args, &block
      else
        link_to *args, &block
      end
    end
  end

  def fb_comments(path: nil)
    %{<div class="fb-comments" data-order-by="reverse_time" data-href="#{request.url}" data-mobile="true" data-numposts="10"></div>}.html_safe
  end

  def fb_share
    %{
      <div class="fb-share-button" data-href="#{request.url}" data-layout="button" data-size="large" data-mobile-iframe="true"><a class="fb-xfbml-parse-ignore" target="_blank" href="https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fdevelopers.facebook.com%2Fdocs%2Fplugins%2F&amp;src=sdkpreparse">Compartilhar</a></div>
    }.html_safe
  end

  def fb_like
    %{
      <div class="fb-like" data-href="https://www.facebook.com/superdev.academy" data-layout="standard" data-action="like" data-size="small" data-show-faces="true" data-share="true" ></div>
    }.html_safe
  end

  def commentable_url(commentable)
    if commentable.is_a?(Discussion)
      anchor_discussion_path(commentable)
    elsif commentable.is_a?(BlogPost)
      blog_post_url(commentable)
    end
  end

  def should_track?
    Rails.env.production? && request.remote_ip != '181.223.128.243'
  end

end
