class Filmreader
  attr_reader :title, :director
  def initialize(title, director)
    @title = title
    @director = director
  end

  def to_s
    # Стивен Спилберг — Список Шиндлера
    "#{@director} — #{@title}"
  end
end
