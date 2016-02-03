defmodule Series do

  @doc """
  Splits up the given string of numbers into an array of integers.
  """
  @spec digits(String.t) :: [non_neg_integer]
  def digits(number_string) do
    number_string
    |> String.graphemes
    |> Enum.reduce([], fn x, acc -> acc ++ [String.to_integer(x)] end)
  end

  @doc """
  Generates sublists of a given size from a given string of numbers.
  """
  @spec slices(String.t, non_neg_integer) :: [list(non_neg_integer)]
  def slices(number_string, size) do
    number_string
    |> digits
    |> slice_by_size(size, [])
  end

  def slice_by_size(l, size, acc) when length(l) < size, do: acc
  def slice_by_size([h|t], size, acc) do
    slice_by_size(t, size, acc ++ [[h|Enum.slice(t, 0, size - 1)]])
  end

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(s, size) when size > byte_size(s), do: raise ArgumentError
  def largest_product(_, 0), do: 1
  def largest_product(number_string, size) do
    number_string
    |> slices(size)
    |> Enum.reduce(0, fn x, acc ->
      cur_series = Enum.reduce(x, 1, &(&1 * &2))
      if cur_series > acc do
        cur_series
      else 
        acc
      end
    end)
  end
end