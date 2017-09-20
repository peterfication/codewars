# https://www.codewars.com/kata/525f3eda17c7cd9f9e000b39/train/ruby
numbers = %w[zero one two three four five six seven eight nine]
numbers.each_with_index do |method, num|
  define_method method do |args = []|
    operand, number = args
    operand ? calculate(num, operand, number) : [operand, num]
  end
end

%i[plus minus times divided_by].each do |operand|
  define_method operand do |args = []|
    [operand, args[1]]
  end
end

def calculate(first, operand, second)
  case operand
  when :plus then first + second
  when :minus then first - second
  when :times then first * second
  when :divided_by then second.zero? ? 0 : first.to_f / second
  end
end
