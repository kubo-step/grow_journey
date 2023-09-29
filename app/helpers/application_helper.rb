module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'Grow Journey'
		page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def turbo_stream_flash
    turbo_stream.update "shared/flash", partial: "shared/flash"
  end
end
