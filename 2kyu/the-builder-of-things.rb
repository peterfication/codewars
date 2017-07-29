# https://www.codewars.com/kata/the-builder-of-things/train/ruby

# imported to handle any plural/singular conversions
require 'active_support/core_ext/string'

# Kind of a dirty solution
class ThingArray < Array
  def each(&block)
    map { |item| item.instance_eval &block }
  end
end

class StringThing < String
  def method_missing(*args)
    self << args.first.to_s
  end
end


class BeingThe

  attr_reader :thing, :argument

  def initialize(thing, argument)
    @thing = thing
    @argument = argument
  end

  def method_missing(args)
    thing.change_method(argument, args.to_s)
    thing
  end
end

class Can

  attr_reader :thing, :argument

  def initialize(thing, argument)
    @thing = thing
    @argument = argument
  end

  def method_missing(*args)
    thing.change_method(argument, 'asdf')
    thing
  end
end


class Thing
  attr_reader :name

  def initialize(name)
    @name = name
    @methods = {}
    @type = nil
    @arguments = nil
  end

  def change_method(method_name, string)
    @methods[method_name] = { type: :is, method_name: method_name, args: string }
  end

  def method_missing(method_name, *args, &block)
    @methods[method_name] ||= {
      method_name: method_name,
      type: @type,
      args: args,
      arguments: @arguments,
      block: block,
    }
    @methods[method_name][:args] = args if args.any?

    call_method(@methods[method_name])
  end

  def call_method(descriptor)
    return descriptor[:cache] if descriptor[:cache]

    case descriptor[:type]
    when :is
      descriptor[:args]
    when :is_a
      true
    when :is_not_a
      false
    when :is_the
      descriptor[:cache] = StringThing.new
    when :being_the
      BeingThe.new(self, descriptor[:method_name])
    when :can
      if descriptor[:cached_args].nil? and (collector = descriptor[:args].first)
        instance_variable_set("@#{collector}", [])
        define_singleton_method(collector) do
          instance_variable_get("@#{collector}")[1..-1]
        end
        @methods[descriptor[:method_name]][:cached_args] = collector
      end

      can_result = self.instance_exec(descriptor[:args].first, &descriptor[:block])
      return can_result unless descriptor[:cached_args]

      cached_can_results = instance_variable_get("@#{descriptor[:cached_args]}")
      cached_can_results << can_result
      instance_variable_set("@#{descriptor[:cached_args]}", cached_can_results)

      can_result
    when :has
      has_results = (1..descriptor[:arguments]).map { |i|
        single = descriptor[:method_name].to_s.singularize
        new_thing = Thing.new(single)
        new_thing.is_a.send(single)
        new_thing
      }

      has_results = has_results.length == 1 ?
        has_results.first :
        ThingArray.new(has_results)

      @methods[descriptor[:method_name]][:cache] = has_results

      has_results
    end
  end

  def is_a
    @type = :is_a
    self
  end

  def is_not_a
    @type = :is_not_a
    self
  end

  def is_the
    @type = :is_the
    self
  end

  def being_the
    @type = :being_the
    self
  end

  def and_the
    @type = :being_the
    self
  end

  def has(number)
    @type = :has
    @arguments = number
    self
  end

  def can
    @type = :can
    self
  end

  def having(number)
    has(number)
  end
end
