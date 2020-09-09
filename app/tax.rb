class Tax
  def import_duty(price)
    price * 0.05
  end

  def sales(price)
    price * 0.1
  end
end