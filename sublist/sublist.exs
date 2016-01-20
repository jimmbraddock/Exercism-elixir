defmodule Sublist do
  @doc """
  Returns whether the first list is first _sublist or first superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(first, second) do
    cond do
        first == second -> :equal
        _compare(first, second) -> :sublist
        _compare(second, first) -> :superlist
        true -> :unequal
    end
  end

  defp _compare([], l), do: true
  defp _compare(l, []), do: false
  defp _compare(first, second) when length(first) > length(second), do: false
  defp _compare(first, second=[h|second_tail]) do
      if _sublist(first, second) do
          true
      else
        _compare(first, second_tail)
      end
  end

  defp _sublist([], l), do: true
  defp _sublist([h|first_tail], [h|second_tail]) do
      first_tail |> _sublist(second_tail)
  end
  defp _sublist(l, k), do: false
  
end
