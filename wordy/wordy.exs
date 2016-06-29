defmodule Wordy do

  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t) :: integer
  def answer(question) do
    tokens =
      ~r/(?:-?\d+|plus|multiplied|minus|divided)/
      |> Regex.scan(question)
      |> Enum.map(fn l -> Enum.at(l, 0) end)
      |> Enum.partition(fn x -> Regex.match?(~r/-?\d+/, x) end)
      |> Tuple.to_list

    numbers = hd(tokens) |> Enum.map(&String.to_integer/1)
    operations = tokens |> tl |> hd

    cond do
        Enum.empty?(numbers) or
          Enum.empty?(operations) or
          length(numbers) - 1 != length(operations) -> raise ArgumentError
        true -> calculate(numbers, operations)
    end
  end

  defp calculate([result|_], []), do: result
  defp calculate([num1, num2 | nt], [op | ot]) do
      case op do
          "plus" -> calculate([num1 + num2 | nt], ot)
          "multiplied" -> calculate([num1 * num2 | nt], ot)
          "minus" -> calculate([num1 - num2 | nt], ot)
          "divided" -> calculate([div(num1, num2) | nt], ot)
      end
  end

end
