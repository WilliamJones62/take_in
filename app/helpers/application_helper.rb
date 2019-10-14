module ApplicationHelper

  def display_date(date)
    if date
      formatted = date.strftime("%Y %m %d")
    else
      formatted = ' '
    end
  end

  def menu_date(date)
    if date
      formatted = date.strftime("%A, %B %d")
    else
      formatted = ' '
    end
  end

  def display_time(time)
    if time
      formatted = time.strftime("%l %M %p")
    else
      formatted = ' '
    end
  end

  def human_boolean(boolean)
      boolean ? 'Yes' : 'No'
  end

end
