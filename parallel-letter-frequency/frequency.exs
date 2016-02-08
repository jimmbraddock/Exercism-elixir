defmodule Frequency do
  @doc """
  Count word frequency in parallel.

  Returns a dict of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: Dict.t
  def frequency(texts, workers) do
    me = self
    texts
    |> Enum.join
    |> String.downcase
    |> String.replace(~r/[^(.(?!\p{L}))]/u, "")
    |> String.split("", trim: true)
    |> _chunck_by_workers(workers)
    |> Enum.map(fn x ->
         spawn(fn() -> 
           send me, {letter_count(x)}
         end)
       end)
    |> _collect_result
  end

  defp _collect_result(pids) do
    pids
    |> Enum.reduce(%{}, fn _, sum -> 
            receive do
              {res} ->
                Enum.reduce(res, sum, fn {k, v}, acc ->
                      Map.update(acc, k, v, &(&1 + v))
                    end)
            end
       end)
  end

  defp letter_count(letters) do
    letters
    |> Enum.reduce(Map.new(), fn(x, map) ->
          Map.update(map, x, 1, &(&1 + 1))
       end)
  end

  defp _chunck_by_workers(src, count)  do
    _chunk(src, div(length(src), count), [])
  end

  defp _chunk([], _, acc), do: acc
  defp _chunk(src, count, acc) when length(src) < count*2 or count == 0, do: acc ++ [src]
  defp _chunk(src, count, acc) do
    src
    |> Enum.slice(count, length(src))
    |> _chunk(count, acc ++ [Enum.slice(src, 0, count)])
  end

end