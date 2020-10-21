class Cart
  def initialize(products = [])
    @products = products
    @final_check = {}
  end

  def add_item(item)
    @products.push(item)
    if !@final_check.key?(item)
      @final_check[item] = 1
    else
      @final_check[item] += 1
    end
  end

  def total_cost
    @products.sum(&:price)
  end

  def list
    @products.join("\n")
  end

  def print_invoice
    @final_check.each_pair { |key, value| puts "#{key}   -  #{value} шт" }
  end
end