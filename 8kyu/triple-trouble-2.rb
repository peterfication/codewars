# https://www.codewars.com/kata/triple-trouble-2/train/ruby

def triple_trouble(one, two, three)
  (0..one.length-1).map { |i| [one[i], two[i], three[i]].join }.join
end
