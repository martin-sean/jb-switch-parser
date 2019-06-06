module HomeHelper

  def percentage(val1, val2)
    100 - (val1 / val2) * 100
  end

  def jb_link(link)
    'https://www.jbhifi.com.au/' + link
  end

  # Limit the number of refreshes to 1 per hour
  def allow_refresh?
    @refresh.nil? || Time.now - @refresh.created_at >= 1.hour
  end

  # Get the time to refresh
  def time_to_refresh
    ((1.hour - (Time.now - @refresh.created_at)) / 60).to_i % 60 + 1
  end

  def two_decimal(num)
    format('%.2f', num)
  end
end