defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    number
      |> String.to_integer
      |> Integer.digits
      |> Enum.reverse
      |> Enum.with_index(1)
      |> Enum.map(fn {el, i} ->
        if rem(i, 2) == 0 do
          {el * 2, i}
        else
          {el, i}
        end
      end)
      |> Enum.map(fn {el, _} ->
        if el > 9 do
          el - 9
        else
            el
        end
      end)
      |> Enum.sum
  end

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    number
    |> checksum
    |> rem(10) == 0
  end

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number) do
    number <> get_last_number(number)
  end

  defp get_last_number(number) do
    number <> "0"
    |> checksum
    |> rem(10)
    |> (&(10 - &1)).()
    |> Integer.to_string
    |> String.last
  end

end
