# https://www.codewars.com/kata/simple-fun-number-337-the-original-number/train/ruby

def original_number(s)
  out = ''
  temp_dict = dict.clone
  current_number_as_string, number = temp_dict.shift

  loop do
    if number_available?(s, current_number_as_string)
      out << number
      s = strip_number(s, current_number_as_string)
    else
      current_number_as_string, number = temp_dict.shift
    end

    break if s.chars.none?
  end

  out.chars.sort.join
end

def dict
  {
    'SIX' => '6',
    'ZERO' => '0',
    'EIGHT' => '8',
    'TWO' => '2',
    'THREE' => '3',
    'SEVEN' => '7',
    'FIVE' => '5',
    'FOUR' => '4',
    'NINE' => '9',
    'ONE' => '1',
  }
end

def number_available?(s, number_as_string)
  number_as_string.chars.reject { |char| s.include?(char) }.empty?
end

def strip_number(s, number_as_string)
  number_as_string.chars.each { |char| s.sub!(char, '') }
  s
end
