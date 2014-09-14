require 'forwardable'

class Galois
  extend Forwardable
  attr_reader :boundaries, :dividing, :set

  def_delegator :set, :size # also boundaries.max / dividing

  def initialize(boundaries, dividing)
    @boundaries = boundaries
    @dividing   = dividing

    build_set
  end

  def squares_ending_in(value)
    set.map { |elm| elm**2 }.select { |e| e.to_s.end_with? "1" }
  end

  def with_reflections
    set_of_strings = set.map(&:to_s)
    set.select { |e| set_of_strings.include? e.to_s.reverse }.map(&:to_i)
  end

  def products_in_set
    reversed_set = set.reverse
    
    [].tap do |results|
      reversed_set.each.with_index do |one, index|
        set.detect do |other|
          break if one * other > boundaries.max
          results << one if reversed_set[0..index].include? one * other
        end
      end
    end
  end

private

  def build_set
    divisor = dividing
    
    @set = [].tap do |set|
      until divisor > boundaries.max
        set << divisor
        divisor += dividing
      end
    end 
  end 
end