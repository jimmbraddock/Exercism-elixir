defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(Dict.t) :: map()
  def transform(input) do
    input
    |> Enum.reduce(%{}, &_transform/2)
  end

  defp _transform({count, words}, transf_acc) do
    Enum.reduce(words, transf_acc, fn (x, acc) ->
        Map.put_new(acc, String.downcase(x), count)
    end)
  end
end
