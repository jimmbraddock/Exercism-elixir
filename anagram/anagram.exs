defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    Enum.filter(candidates, &(_check(base, &1)))
  end

  defp _check(base, candidate) when byte_size(base) != byte_size(candidate), do: false
  defp _check(base, candidate) do
      cond do
        String.downcase(candidate) == String.downcase(base) -> false
        _transform(candidate) == _transform(base) -> true
  end

  defp _transform(x) do
      x                   |> 
      String.downcase     |> 
      String.to_char_list |> 
      Enum.sort
  end

end
