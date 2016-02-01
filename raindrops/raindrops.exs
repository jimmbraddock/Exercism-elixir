defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    convert(number, [])
  end

  defp convert(n, acc) when rem(n, 3) == 0, do: convert(div(n, 3), acc ++ ["Pling"])
  defp convert(n, acc) when rem(n, 5) == 0, do: convert(div(n, 5), acc ++ ["Plang"])
  defp convert(n, acc) when rem(n, 7) == 0, do: convert(div(n, 7), acc ++ ["Plong"])
  defp convert(n, []), do: to_string(n)
  defp convert(_, acc), do: acc |> Enum.uniq |> Enum.join
end
