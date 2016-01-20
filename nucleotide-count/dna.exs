defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    check_nucleotide(nucleotide)

    strand                          |>
    Enum.map(&check_nucleotide/1)   |>
    Enum.count(&(&1 == nucleotide))
  end

  defp check_nucleotide(n) do
    if !Enum.member?(@nucleotides, n) do
      raise ArgumentError
    else
      n
    end
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: Dict.t
  def histogram(strand) do
    Enum.reduce(@nucleotides, %{}, fn(x, map) ->
        Map.put(map, x, count(strand, x))
      end)
  end

end