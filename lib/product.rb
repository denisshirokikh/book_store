class Product
  attr_accessor :price, :amount

  def initialize(params)
    @price = params[:price]
    @amount = params[:amount]
  end

  def to_s
    "#{@price} руб. "
  end

  def update(params)
    @price = params[:price] if params[:price]
    @amount = params[:amount] if params[:amount]
  end

  def self.from_file(file_path)
    raise NotImplementedError
  end

  def left_in_stock
    @amount -= 1
    to_s
  end
end
