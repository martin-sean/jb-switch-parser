module HomeHelper
  def percentage(val1, val2)
    100 - (val1 / val2) * 100
  end

  def get_jb_link(link)
    'https://www.jbhifi.com.au/' + link
  end
end