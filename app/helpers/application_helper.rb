module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'Grow Journey'
		page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end
