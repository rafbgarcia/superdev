module ApplicationHelper

  def post_body(body)
    raw(h(body.html_safe).gsub(/\n/, "<br>\n"))
  end

  def menu_item(text, path)
    item  = '<li'
    item += ' class="active"' if request.path == path
    item += '>'
    item += link_to(text, path)
    item += '</li>'

    item.html_safe
  end

  def is_page?(page)
    params[:controller] == 'site' && params[:action] == page
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
