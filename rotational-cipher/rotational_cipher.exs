defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
      text |> String.graphemes |> crypt(shift, []) |> to_string
  end

  defp crypt([], _, acc), do: acc
  defp crypt([h|t], offset, acc) do
    crypt(t, offset, acc ++ [convert(h, offset)])
  end

  defp convert(_=<<nb>>, offset) when nb >=?A and nb <= ?Z and nb + offset > ?Z, do: ?A - 1 + abs(?Z - nb - offset)
  defp convert(_=<<nb>>, offset) when nb >=?A and nb <= ?Z, do: nb + offset
  defp convert(_=<<nb>>, offset) when nb >=?a and nb <= ?z and nb + offset > ?z, do: ?a - 1 + abs(?z - nb - offset)
  defp convert(_=<<nb>>, offset) when nb >=?a and nb <= ?z, do: nb + offset
  defp convert(n, _), do: n
end
