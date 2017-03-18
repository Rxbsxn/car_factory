class Car
    
    AVAILABLE_COLORS = []

    def initialize(brand, color: nil)
        @brand = brand
        @color = color ||= self.class.next_available_color
    end

    def brand
        humanize(@brand)
    end

    def color_name        
        humanize(@color)
    end

    def humanize(obj)
        obj.to_s.split('_').map(&:capitalize).join(' ')    
    end

    def self.next_available_color
        AVAILABLE_COLORS.any? ? available_color.next : nil
    end

    def self.available_color
        @@available_color ||= AVAILABLE_COLORS.cycle
    end
end