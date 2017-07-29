# https://www.codewars.com/kata/alternating-case-%3C-equals-%3E-alternating-case/train/ruby

# Didn't know about String#swapcase before this challenge
class String
  def to_alternating_case
    self.chars.map { |c| c =~ /[[:upper:]]/ ? c.downcase : c.upcase }.join
  end
end
