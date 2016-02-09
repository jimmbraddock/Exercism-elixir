defmodule Minesweeper do

@mine "*"

  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]
  def annotate([]), do: []
  def annotate(board) do
    board
    |> Enum.with_index
    |> Enum.reduce(%{}, &div_by_cell/2)
    |> defuse
    |> Enum.chunk(byte_size(hd(board)))
    |> Enum.map(&Enum.join/1)
  end

  defp div_by_cell({line, line_number}, board) do
   line
   |> String.graphemes
   |> Enum.with_index
   |> Enum.reduce(board, fn {cell, cell_number}, div_line -> 
         Map.put_new(div_line, {line_number, cell_number}, cell)
      end)
  end

  defp defuse(cells) do
    Enum.reduce(cells, [], fn {k, v}, defusing_board -> 
        if v == @mine do
            defusing_board ++ [@mine]
        else
            defusing_board ++ [get_cell_mines(cells, k)]
        end
    end)
  end

  defp get_cell_mines(cells, {i, j}) do
     candidates = for x <- [-1, 0, 1], y <- [-1, 0, 1], do: {x+i, y+j}
     count = Enum.reduce(candidates, 0, fn cell, mines_counter ->
           cond do
             Map.get(cells, cell) == @mine -> mines_counter + 1
             true -> mines_counter
           end
         end)
     cond do
       count == 0 -> " "
       true -> Integer.to_string(count)
     end
  end

end