class Car
    
    AVAILABLE_COLORS = []

    def initialize(brand, opts = {})
        @brand = brand
        @color = opts[:color] ||= nil
    end

    def brand
        @brand.to_s.capitalize
    end

    def color_name        
        @color.to_s.gsub('_', ' ').split.map(&:capitalize).join(' ')
    end    
    
end