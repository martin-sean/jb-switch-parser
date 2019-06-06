module HomeHelper
  def percentage(val1, val2)
    100 - (val1 / val2) * 100
  end
end