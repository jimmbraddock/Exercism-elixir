defmodule Squares do
  @moduledoc """
  Calculate sum of squares, square of sums, difference between two sums from 1 to a given end number.
  """

  @doc """
  Calculate sum of squares from 1 to a given end number.
  """
  @spec sum_of_squares(pos_integer) :: pos_integer
  def sum_of_squares(number) do
    (for x <- 1..number, do: x*x)
    |> Enum.sum
  end

  @doc """
  Calculate square of sums from 1 to a given end number.
  """
  @spec square_of_sums(pos_integer) :: pos_integer
  def square_of_sums(number) do
    sum = div((1 + number)*number, 2)
    sum * sum
  end

  @doc """
  Calculate difference between sum of squares and square of sums from 1 to a given end number.
  """
  @spec difference(pos_integer) :: pos_integer
  def difference(number) do
    square_of_sums(number) - sum_of_squares(number)
  end

end