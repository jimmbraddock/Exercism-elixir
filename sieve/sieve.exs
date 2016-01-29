defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    2..limit
    |> Enum.to_list
    |> _filter_range([])
  end

  defp _filter_range([], acc), do: acc
  defp _filter_range(range=[h|_], acc) do
    range
    |> Enum.reject(&(rem(&1, h) == 0))
    |> _filter_range(acc ++ [h])
  end

end

