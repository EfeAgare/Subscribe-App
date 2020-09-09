require_relative "./product.rb"


puts "Welcome to Mini-Mart"

puts "Enter the file number to execute"

file_number = gets.chomp().to_i

begin (item_list = File.readlines(File.dirname(__FILE__) + "/input_files/input_#{file_number}.txt")).any?
  products = Product.new(item_list)
  products.execute
rescue Errno::ENOENT
  puts 'File not found'
  puts "Enter an integer from 1 to 3"
end
