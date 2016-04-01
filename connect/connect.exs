defmodule Connect do
  @doc """
  Calculates the winner (if any) of a board
  using "O" as the white player
  and "X" as the black player
  """
  @spec result_for([String.t]) :: :none | :black | :white
  def result_for(board) do
    cond do
      board |> board_for_black |> wins? -> :black
      board |> board_for_white |> wins? -> :white
      true -> :none
    end
  end

  defp board_for_black(board) do
    board
    |> transpose
    |> create_board
    |> Enum.filter(fn {_, _, v} -> v == "X" end)
    |> Enum.map(fn {x, y, _} -> {x, y} end)
  end

  defp transpose(board) do
    board 
    |> Enum.map(&(String.codepoints(&1)))
    |> List.zip
    |> Enum.map(&Enum.join(Tuple.to_list(&1)))
  end

  defp create_board(board) do
    for row <- 0..length(board) - 1,
        col <- 0..length(board) - 1,
        value = String.at(Enum.at(board, row), col),
        do: {row, col, value}
  end

  defp board_for_white(board) do
    board
    |> create_board
    |> Enum.filter(fn {_, _, v} -> v == "O" end)
    |> Enum.map(fn {x, y, _} -> {x, y} end)
  end

  defp wins?([]), do: false
  defp wins?(board) do
    {rows, _} = Enum.max_by(board, fn {x, _} -> x end)

    board
    |> Enum.filter(fn {x, _} -> x == 0 end)
    |> Enum.any?(fn {x, y} ->
      connect?({x, y}, board, rows)
    end)
  end  

  defp connect?(cell={x, _}, bricks, goal) do
    next = get_next_cells(cell, bricks)
    cond do
      goal == x ->
        true
      length(next) == 0 ->
        false
      true ->
        Enum.any?(next, fn c ->
          connect?(c, List.delete(bricks, cell), goal)
        end) 
    end
  end

  defp get_next_cells({x, y}, board) do
    Enum.filter(board, fn cell -> 
      cell in [
               {x + 1, y},
               {x - 1, y},
               {x, y + 1},
               {x, y - 1},
               {x + 1, y - 1}, 
               {x - 1, y + 1}
              ]
    end)
  end
end
