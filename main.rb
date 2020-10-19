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



collection = ProductCollection.from_dir(__dir__ + '/data')

# Сортируем продукты по возрастанию цены с помощью метода sort! экземпляра
# класса ProductCollection
collection.sort!(by: :title, order: :asc)

stock = {}
user_input = ""
total_to_pay = 0
items_to_bye = []
until user_input == 0
  puts "Что хотите купить:"
  collection.to_a.each_with_index do |product, index |
    puts "#{index + 1}. #{product}"
    stock[index+1] = product
  end
  puts "0. Выход"
  user_input = STDIN.gets.to_i.abs
  if user_input == 0
    puts "Вы купили: "
    items_to_bye.each {|item| puts item}
    puts "С Вас — #{total_to_pay} руб. Спасибо за покупки!"
  else
  stock.fetch(user_input).left_in_stock
  puts "Вы выбрали: #{stock.fetch(user_input)}"
  items_to_bye << stock.fetch(user_input)
  total_to_pay += stock.fetch(user_input).price
  puts "Всего товаров на сумму:#{total_to_pay} руб"
  end
end



