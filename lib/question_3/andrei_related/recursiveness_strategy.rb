module Andrei
  class RecursivenessStrategy
    OUTSIDE_LIMIT = 3

    attr_reader :x, :y, :t, :tuple, :precission

    def initialize(x, y, t, options = {})
      @x, @y, @t  = x, y, t
      @precission = options.fetch :precission, 5
      
      @tuple = [x, y]
    end

    def call
      return 0 if tuple.map(&:abs).max >= OUTSIDE_LIMIT

      if t == 0
        tuple == [0, 0] ? 1 : 0
      else
        value.round precission
      end
    end

  private

    def value
      0.2 * [[0,0], [1,0], [0,1], [-1, 0], [0, -1]].reduce(0) do |sum, elm|
        sum + self.class.new(step(x, elm[0]), step(y, elm[1]), t-1).call
      end
    end

    def step(axis_value, step_length)
      next_axis_value = axis_value + step_length
      next_axis_value.abs >= OUTSIDE_LIMIT ? axis_value : next_axis_value
    end
  end
end