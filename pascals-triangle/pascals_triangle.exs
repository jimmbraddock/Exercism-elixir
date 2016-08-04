defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(1), do: [[1]]
  def rows(2), do: [[1], [1, 1]]
  def rows(num) do
    rows(2)
    |> Enum.reverse
    |> create_triangle(num - 2)
    |> Enum.reverse
  end

  def create_triangle(rows, 0), do: rows
  def create_triangle(rows=[h|t], num) do
    next_row = h
        |> calc_mid_part
        |> List.insert_at(0, 1)
        |> List.insert_at(length(h) + 1, 1)
    create_triangle([next_row|rows], num - 1)
  end

  def calc_mid_part(last_row) do
    last_row
    |> Enum.chunk(2, 1)
    |> Enum.map(&Enum.sum/1)
  end
end
