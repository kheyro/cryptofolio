module ApplicationHelper

  def display_percent(number)
    raw "<span class=\"#{(number < 0) ? 'red' : 'green'}\">#{(number * 100).round(2)}%</span>" if  number && number > 0
  end

end
