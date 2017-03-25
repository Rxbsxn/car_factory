class CarPark
  attr_reader :capacity, :cars
  def initialize(capacity)
    @capacity = capacity
    @cars = []
  end

  def receive(cars)
    @cars += [cars].flatten.shift(places_left)
  end
  
  def places_left
    @capacity - @cars.count
  end

  def retrieve(cars_set)
    @cars.pop(cars_set)
  end

  def brands
   @cars.map(&:brand).uniq
  end

  def brands_stats
    cars_sorted = @cars.group_by(&:brand)
    cars_sorted.each_pair{|name, quantity| cars_sorted[name] = quantity.count}
  end
end