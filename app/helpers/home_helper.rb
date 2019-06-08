module HomeHelper

  def percentage(val1, val2)
    format_decimal(100 - (val1 / val2) * 100, 0)
  end

  def jb_link(link)
    'https://www.jbhifi.com.au' + link
  end

  # Limit the number of refreshes to 1 per hour
  def allow_refresh?
    @refresh.nil? || Time.now - @refresh.created_at >= 1.hour
  end

  # Get the time to refresh
  def time_since_refresh
    distance_of_time_in_words_to_now @refresh.created_at
  end

  def format_decimal(num, places)
    format("%.#{places}f", num)
  end

  def new_game?(game)
    Time.now - game.created_at < 7.days
  end
end