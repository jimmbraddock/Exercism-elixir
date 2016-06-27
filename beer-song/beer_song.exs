defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t
  def verse(number) do
    cond do
      number - 1 == 0 -> """
No more bottles of beer on the wall, no more bottles of beer.
Go to the store and buy some more, 99 bottles of beer on the wall.
"""
      number - 1 == 1 -> """
1 bottle of beer on the wall, 1 bottle of beer.
Take it down and pass it around, no more bottles of beer on the wall.
"""
      true -> """
#{number-1} bottles of beer on the wall, #{number-1} bottles of beer.
Take one down and pass it around, #{number-2} bottle#{if number - 2 != 1 do "s" end} of beer on the wall.
"""
    end
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t) :: String.t
  def lyrics(range \\ 100..1) do
    range
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end
end
