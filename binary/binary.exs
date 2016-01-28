defmodule Binary do
  use Bitwise
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) when is_binary(string) do
    string
    |> to_decimal(0)
  end

  def to_decimal("", acc), do: acc
  def to_decimal("0" <> string, acc), do: to_decimal(string, acc <<< 1)
  def to_decimal("1" <> string, acc), do: to_decimal(string, (acc <<< 1) ||| 1)
  def to_decimal(_, _), do: 0
end
