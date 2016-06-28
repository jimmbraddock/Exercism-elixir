defmodule BinarySearch do
  @doc """
    Searches for a key in the list using the binary search algorithm.
    It returns :not_found if the key is not in the list.
    Otherwise returns the tuple {:ok, index}.

    ## Examples

      iex> BinarySearch.search([], 2)
      :not_found

      iex> BinarySearch.search([1, 3, 5], 2)
      :not_found

      iex> BinarySearch.search([1, 3, 5], 5)
      {:ok, 2}

  """

  @spec search(Enumerable.t, integer) :: {:ok, integer} | :not_found
  def search([], _), do: :not_found
  def search(list, key) do
    if Enum.sort(list) != list do
      raise ArgumentError, "expected list to be sorted"
    else
      search(list, key, 0, length(list))
    end
  end

  defp search(_, _, low, high) when high < low, do: :not_found
  defp search(l, key, low, high) do
    middle = div(low + high, 2)
    value = Enum.at(l, middle)

    cond do
      value > key -> search(l, key, low, middle - 1)
      value < key -> search(l, key, middle + 1, high)
      true -> {:ok, middle}
    end
  end
end
