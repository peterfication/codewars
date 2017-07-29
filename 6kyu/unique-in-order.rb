# https://www.codewars.com/kata/unique-in-order/train/ruby

def unique_in_order(iterable)
  iterable = iterable.split('') if iterable.is_a? String

  before = nil
  iterable.map { |char|
    unless char == before
      before = char
      char
    end
  }.compact
end
