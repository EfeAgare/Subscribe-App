require_relative "./tax.rb"
# item_list = ["1 imported box of chocolates at 10.00", "1 imported bottle of perfume at 47.50"]

# item_list = ["1 imported bottle of perfume at 27.99", "1 bottle of perfume at 18.99", "1 packet of headache pills at 9.75", "3 imported boxes of chocolates at 11.25"]

class Product
  EXEMPTED_PRODUCTS = %w[book food pills cholocate chocolates]

  attr_accessor :price, :tax, :product, :display_items

  def initialize(product_list)
    @product_list = product_list
    @display_items = []
    @total_tax_array = []
    @total_product_price_array = []
  end

  def product_tax
    Tax.new()
  end

  def calculate_price
    @product_list.map do |item|
      @product = item.split(" at ")
      @price = product[1].to_f

      sales_tax = 0.0

      if !(EXEMPTED_PRODUCTS & item.split(" ")).any?
        sales_tax = product_tax.sales(@price)
      end

      import_duty_tax = 0.0

      if @product[0].include?("imported")
        import_duty_tax = product_tax.import_duty(@price)
      end

      @tax = import_duty_tax + sales_tax

      total_tax_array

      total_product_price_array
    end
  end

  # get the product quantity
  def quantity
    @product[0].split(" ")[0].to_i
  end

  # product tax
  def total_tax
    product_tax.round_up_tax(@tax) * quantity
  end

  def total_tax_array
    @total_tax_array << total_tax
  end

  def sum_total_tax_array
    @total_tax_array.reduce(:+)
  end

   # product price
   def total_price
    ((@price * quantity) + total_tax).round(2)
  end

  def total_product_price_array
    @total_product_price_array << total_price
  end

  def sum_total_product_price_array
    @total_product_price_array.reduce(:+)
  end


end


item_list = ["2 book at 12.49", "1 music CD at 14.99", "1 cholocate bar at 0.85"]

products = Product.new(item_list)
puts products.calculate_price
puts products.sum_total_tax_array
puts products.sum_total_product_price_array
