require_relative 'car'
class CarFactory 
  attr_reader :brands
  SUPPORTED_BRANDS = %i(fiat lancia ford subaru)
  
  def initialize(name, brands: nil)
    @name = name
    @brands = [brands].flatten
    check_supported
  end

  def name
    "#{@name} (produces #{brands_humanize})"
  end

  def make_car(brand = nil)
    if brand_is_defined(brand) || is_not_empty?(brand)
      raise UnsupportedBrandException, "Factory does not have a brand or do not support it"
    end
    Car.new(brand || @brands.first)
  end

  def make_cars(opts)
    cars = []
    if opts.respond_to?(:each_pair)
      opts.select! { |brand, quantity| SUPPORTED_BRANDS.include? brand }
      opts.each_pair do |brand, quantity|
        quantity.times { cars << make_car(brand) }
      end
    else
      opts.times do |n|
        cars << make_car(@brands[n % @brands.length])
      end
    end
    
    cars  
  end
  
  private

  def brands_humanize
    @brands.map(&:capitalize).join(', ')
  end

  def symbols_to_s(symbols_set)
    [symbols_set].flatten.join(' ').split(' ')
  end

  def check_supported
     until( symbols_to_s(@brands) - symbols_to_s(SUPPORTED_BRANDS)).empty?
        raise UnsupportedBrandException, "Brand not supported: '#{@brands.join(' ').capitalize}'"
     end 
  end
  
  def brand_is_defined(brand)
    !@brands.include?(brand) && brand
  end
  def is_not_empty?(brand)
    brand.nil? && @brands.length > 1
  end
end

class UnsupportedBrandException < Exception
end