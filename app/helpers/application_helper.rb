module ApplicationHelper
  def page_title(page_title = "")
    base_title = "Grow Journey"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def turbo_stream_flash
    turbo_stream.update "flash", partial: "shared/flash"
  end

  def error_message_for(object, field)
    return unless object.errors[field].any?

    field_name = object.class.human_attribute_name(field)
    message = object.errors[field].join(", ")
    messages = "*#{field_name}#{message}"
    content_tag(:p, messages, class: "text-sm text-red-500")
  end

  def category_icon(category_name)
    case category_name
    when "勉強"
      "icon/small_flower_red.png"
    when "仕事"
      "icon/small_flower_yellow.png"
    when "趣味"
      "icon/small_flower_skyblue.png"
    when "健康"
      "icon/small_flower_orange.png"
    when "美容"
      "icon/small_flower_pink.png"
    else
      "icon/small_flower_brown.png"
    end
  end

  def default_meta_tags
    {
      site: "GrowJourney",
      title: "GrowJourney",
      reverse: true,
      separator: "|",
      description: "-自分の成長記録サービス-",
      keywords: "GrowJourney,growjourney,grow,journey,成長,自己成長,記録,目標,目標設定",
      canonical: request.original_url,
      noindex: ! Rails.env.production?,
      icon: {
        href: image_url('icon.png'),
      },
      og: {
        site_name: :site,
        title: :title,
        description: :disposition,
        type: "website",
        url: request.original_url,
        image: image_url("ogp_image.png"),
        locale: "ja_JP"
      },
      twitter: {
        site: "@",
        card: "summary_large_image",
        image: image_url("ogp_image.png"),
      }
    }
  end
end
