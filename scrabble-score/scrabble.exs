defmodule Scrabble do

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    String.split(word, "", trim: true)
    |> Enum.reduce(0, &_calculate_score/2)
  end

  defp _get_score(letter) when letter in ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"], do: 1
  defp _get_score(letter) when letter in ["D", "G"], do: 2
  defp _get_score(letter) when letter in ["B", "C", "M", "P"], do: 3
  defp _get_score(letter) when letter in ["F", "H", "V", "W", "Y"], do: 4
  defp _get_score(letter) when letter == "K", do: 5
  defp _get_score(letter) when letter in ["J", "X"], do: 8
  defp _get_score(letter) when letter in ["Q", "Z"], do: 10
  defp _get_score(_), do: 0

  defp _calculate_score(letter, total) do
      total + _get_score(String.upcase(letter))
  end
end