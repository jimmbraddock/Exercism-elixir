defmodule Palindromes do

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map() 
  def generate(max_factor, min_factor \\ 1) do
    palindromes = for a <- min_factor..max_factor,
                      b <- a..max_factor,
                      prod = a*b,
                      palindrome?(prod),
                      do: {prod, [a, b]}
           
    Enum.reduce(palindromes, %{}, fn {prod, pair}, acc ->
      Map.update(acc, prod, [pair], &(&1 ++ [pair]))
    end)
  end

  def palindrome?(n) do
    s = Integer.to_string(n)
    s == String.reverse(s)
  end
end

