module Andrei
  class IterativeStrategy
    OUTSIDE_LIMIT = 3

    attr_reader :x, :y, :t, :precission

    def initialize(x, y, t, options = {})
      @x, @y, @t  = x, y, t
      @precission = options.fetch :precission, 3
    end

    def board
      t.times.inject(initial_board) do |tmp_board, _|
        empty_board.tap do |resulting_board|
          adjacencies.each do |adjacency|
            tmp_board.keys.each do |tile|
              resulting_board[product tile, adjacency] += step tile, tmp_board
            end
          end
        end
      end
    end

    def call
      board[[x,y]].round precission
    end

  private

    def initial_board
      @initial_board ||= empty_board.merge [0,0] => 1.0
    end

    def step(tile, board)
      0.2 * board[tile]
    end

    def adjacencies
      [[0,0], [1,0], [0,1], [-1, 0], [0, -1]]
    end

    def product(arr1, step)
      dot_product = [arr1, step].transpose.map { |e| e.inject &:+ }
      dot_product.map(&:abs).max >= OUTSIDE_LIMIT ? arr1 : dot_product
    end

    def empty_board
      Hash.new { |hash, key| hash[key] = 0 }
    end
  end
end