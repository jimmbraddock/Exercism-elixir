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
    for x <- 0..length(rows) - 1,
        y <- 0..length(cols) - 1,
        row = Enum.at(rows, x),
        col = Enum.at(cols, y),
        el = Enum.at(row, y),
        Enum.all?(row, &(&1 <= el)),
        Enum.all?(col, &(&1 >= el)),
    do: {x, y}
  end

end