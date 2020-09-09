require_relative "./product.rb"
require_relative "./read_file.rb"


puts "Welcome to Mini-Mart"

puts "Enter the file number to execute"

file_number = gets.chomp().to_i
item_list = ReadFile.new().read(file_number)

products = Product.new(item_list)
products.execute

