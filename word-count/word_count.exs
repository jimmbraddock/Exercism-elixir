defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map()
  def count(sentence) do
    sentence |> downcase |> split |> words_count
  end

  def downcase(sentence) do
      String.downcase(sentence)
  end

  def split(sentence) do
      String.split(sentence, ~r/[^\w\-]|_/u, trim: true)
  end

  def words_count(words) do
    Enum.reduce(words, Map.new(), fn(x, map) ->
        Map.update(map, x, 1, &(&1 + 1))
    end)
  end
end
