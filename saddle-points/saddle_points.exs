defmodule Matrix do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    String.split(str, "\n") |> Enum.map(fn x ->
      x
        |> String.strip
        |> String.split(" ")
        |> Enum.map(&String.to_integer/1)
    end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str
      |> rows
      |> List.zip
      |> Enum.map(&Tuple.to_list(&1))
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    cols = str |> columns
    rows = str |> rows 
    Enum.reduce(rows, [], fn row, acc ->
      row_index = Enum.find_index(rows, &(&1 == row))
      acc ++ get_saddle_points_in_row(row, cols, row_index)
    end)
  end

  @spec get_saddle_points_in_row([], [], integer) :: [{integer, integer}]
  defp get_saddle_points_in_row(row, cols, row_index) do
    Enum.reduce(Stream.with_index(row), [], fn {value, col_index}, points ->
      col = Enum.at(cols, col_index)
      if saddle_point?(value, row, col) do
        points ++ [{row_index, col_index}]
      else
        points
      end
    end)
  end

  @spec saddle_point?(integer, [], []) :: boolean
  defp saddle_point?(value, row, col) do
    Enum.all?(row, &(&1 <= value)) and Enum.all?(col, &(&1 >= value))
  end
  
end