require_relative "./tax.rb"

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

  def execute
    calculate_price
    show_total_product_tax
    show_total_product_price
    show_receipt
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

      product_list_array
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

  def show_total_product_tax
    @display_items << "Sales Taxes: #{ "%.2f" % sum_total_tax_array.round(2)}"
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

  def show_total_product_price
    @display_items << "Total: #{"%.2f" % sum_total_product_price_array.round(2)}"
  end

  # show product
  def product_to_s
    @product[0].strip() + ": " + "%.2f" % total_price.to_s
  end

  def product_list_array
    @display_items << product_to_s
  end

  def show_receipt
    puts "*************************************"
    puts "           Mini-Mart Receipt         "
    puts "*************************************"
    puts @display_items

    puts "*************************************"
  end
end

