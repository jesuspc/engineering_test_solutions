require 'forwardable'

class Galois
  extend Forwardable
  attr_reader :boundaries, :dividing

  def_delegator :set, :size # also boundaries.max / dividing

  def initialize(boundaries, dividing)
    @boundaries = boundaries
    @dividing   = dividing
  end

  def squares_ending_in(value)
    set.map { |elm| elm**2 }.select { |e| e.to_s.end_with? "1" }
  end

  def with_reflections
    set_of_strings = set.map(&:to_s)
    set.select { |e| set_of_strings.include? e.to_s.reverse }.map(&:to_i)
  end

  # Searching for the products by checking all the possible permutations is an
  # expensive task. the proccessing time can be drastically reduced
  # by noticing a few characteristics of the operation:
  # 
  # 1. If the product of two numbers is bigger than the maximum in the set
  #    there's no need to check if it's present inside. 
  # 2. If the product of a number with another is bigger than the maximum 
  #    in the set, the product of the same number by the element that is next to
  #    the other in the set (which is sorted ASC) will be even bigger.
  #
  # To use those two properties in an optimal way it is worth to reverse the 
  # set, so big numbers are first, and start the permutations with the
  # set without reverting. Once the product of a permutation is bigger than 
  # the maximum value we can stop checking for that number because its product
  # with any other number will be bigger. 
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

  # We can build the set of all the numbers that are evenly divisible by 
  # another just by creating an array like [num, num*2, num*3, ...]. Note that
  # num/num = 1, num*2/num = 2, etc.
  def set
    @set ||= begin
      divisor = dividing
      
      [].tap do |tmp_set|
        until divisor > boundaries.max
          tmp_set << divisor
          divisor += dividing
        end
      end
    end
  end 
end