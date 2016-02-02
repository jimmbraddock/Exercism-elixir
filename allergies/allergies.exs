defmodule Allergies do

use Bitwise

@material %{
  "eggs" => 1,
  "peanuts" => 2, 
  "shellfish" => 4, 
  "strawberries" => 8,
  "tomatoes" => 16,
  "chocolate" => 32,
  "pollen" => 64,
  "cats" => 128
}

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags) do
    Enum.reduce(@material, [], fn {k, v}, acc
        when (flags &&& v) != 0 -> [k|acc]
        (_, acc) -> acc
      end
    )
  end


  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    (flags &&& @material[item]) != 0
  end
end
