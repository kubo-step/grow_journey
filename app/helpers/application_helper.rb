module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'Grow Journey'
		page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def turbo_stream_flash
    turbo_stream.update "flash", partial: "shared/flash"
  end

  def error_message_for(object, field)
    return unless object.errors[field].any?

    field_name = object.class.human_attribute_name(field)
    message = object.errors[field].join("/")
    messages = "*#{field_name}#{message}"
    content_tag(:p, messages, class: "text-sm text-red-500")
  end
end
