# https://www.codewars.com/kata/dollars-and-cents/train/elixir

defmodule Cashier do
  def format_money(amount) do
    "$#{:erlang.float_to_binary(amount, decimals: 2)}"
  end
end
