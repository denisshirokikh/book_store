class Cart
  def initialize(products = [])
    @products = products
  end

  def add_item(item)
    @products.push(item)
  end

  def total_cost
    @products.sum(&:price)
  end

  def list
    @products.join("\n")
  end
end