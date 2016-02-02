defmodule Allergies do

@material [ 
  "eggs",
  "peanuts", 
  "shellfish", 
  "strawberries",
  "tomatoes",
  "chocolate",
  "pollen",
  "cats"
]

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags) do
    flags
    |> Integer.digits(2)
    |> Enum.reverse
    |> Enum.zip(@material)
    |> Enum.reduce([], fn({flag, mat}, acc) when flag == 1 ->
                         List.insert_at(acc, -1, mat)
                       (_, acc) ->
                         acc
    end)
  end


  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    item in list(flags)
  end
end
