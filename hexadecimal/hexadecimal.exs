defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @dictionary "0123456789abcdef"
              |> String.codepoints
              |> Enum.with_index
              |> Enum.into(%{})

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    if Regex.match?(~r/^[0-9a-fA-F]+$/, hex) do
      hex
      |> String.downcase
      |> String.reverse
      |> String.codepoints
      |> Enum.with_index
      |> Enum.reduce(0, fn {v, i}, acc ->
          acc = acc + @dictionary[v] * :math.pow(16, i)
      end)
    else
      0
    end
  end
end
