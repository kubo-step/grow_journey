module GoalsHelper
  def category_icon(category_name)
    case category_name
    when "勉強"
      "icon/small_flower_yellow.png"
    when "仕事"
      "icon/small_flower_skyblue.png"
    when "趣味"
      "icon/small_flower_purple.png"
    when "健康"
      "icon/small_flower_red.png"
    when "美容"
      "icon/small_flower_pink.png"
    else
      "icon/small_flower_brown.png"
    end
  end
end