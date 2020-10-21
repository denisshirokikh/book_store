class Music < Product
  attr_accessor :title, :singer, :genre, :year

  def self.from_file(file_path)
    lines = File.readlines(file_path, encoding: 'UTF-8').map { |l| l.chomp }

    self.new(
        title: lines[0],
        singer: lines[1],
        genre: lines[2],
        year: lines[3],
        price: lines[4].to_i,
        amount: lines[5].to_i
    )
  end

  def initialize(params)
    super
    @title = params[:title]
    @singer = params[:singer]
    @genre = params[:genre]
    @year = params[:year]
  end

  def to_s
    "Альбом #{@singer} - #{@title}, #{@genre}, #{@year} г., #{super}"
  end

  def left_in_stock
    super
  end

end