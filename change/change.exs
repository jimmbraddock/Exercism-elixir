defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' amountue would equal the correct amount of change.
    It returns :error if it is not possible to compute the right amount of coins.
    Otherwise returns the tuple {:ok, map_of_coins}

    ## Examples

      iex> Change.generate(3, [5, 10, 15])
      :error

      iex> Change.generate(18, [1, 5, 10])
      {:ok, %{1 => 3, 5 => 1, 10 => 1}}

  """

  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(_, []), do: :error
  def generate(amount, values) do
    values |> Enum.sort(&(&1 > &2)) |> change(amount, %{})
  end

  defp change([], amount, _) when amount > 1, do: :error
  defp change([h|_], amount, acc) when rem(amount, h) == 0, do: {:ok, Map.put(acc, h, trunc(amount/h))}
  defp change([h|t], amount, acc) do
      change(t, amount - h*trunc(amount/h), Map.put(acc, h, trunc(amount/h)))
  end
end
