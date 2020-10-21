if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require_relative 'lib/product'
require_relative 'lib/book'
require_relative 'lib/movie'
require_relative 'lib/music'
require_relative 'lib/product_collection'
require_relative 'lib/cart'

collection = ProductCollection.from_dir(__dir__ + '/data').to_a

user_input = ""
cart = Cart.new
until user_input == 0
  puts "Что хотите купить:"
  collection.each_with_index do |product, index|
    puts "#{index+1}. #{product} (Остаток: #{product.amount})"
  end
  puts "0. Выход"
  user_input = STDIN.gets.to_i
  if user_input == 0
    puts "**********СПИСОК ПОКУПОК**********"
    cart.print_invoice.each do |key, value|
      puts "#{key}   -  #{value} шт - Сумма: #{key.price * value} "
    end
    puts "ИТОГ — #{cart.total_cost} руб."
    puts "********Спасибо за покупки!********"
  elsif user_input > collection.size || user_input < 0
    puts "Введите коректное значение от 0 до #{collection.size}"
  else
    user_choice = collection[user_input - 1]
    cart.add_item(user_choice)
    user_choice.left_in_stock
    puts "Вы выбрали:"
    puts cart.list
    "Всего товаров на сумму:#{cart.total_cost} руб"
    collection.delete(user_choice) if user_choice.amount.zero?
    end
end
