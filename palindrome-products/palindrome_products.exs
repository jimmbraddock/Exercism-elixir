defmodule Palindromes do

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map() 
  def generate(max_factor, min_factor \\ 1) do
    max_factor
    |> _generate_palindroms(min_factor)
    |> Enum.reduce( %{}, fn [h|t], acc ->
          Map.update(acc, String.to_integer(h), t, &(&1 ++ t) )
       end)
  end

  def _generate_palindroms(max, min) do
    for a <- min..max,
        b <- a..max,
        "#{a*b}" == String.reverse("#{a*b}"),
        into: [],
        do: ["#{a*b}", [a, b]]
  end
end
