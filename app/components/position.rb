class Position
    attr_accessor :x,:y

    def initialize(values)
        @x = values[:x]
        @y = values[:y]
    end
end
