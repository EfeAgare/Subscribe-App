class Tax
  def import_duty(price)
    price * 0.05
  end

  def sales(price)
    price * 0.1
  end

  def round_up_tax(tax)
    (tax * 20).ceil / 20.0
  end
end