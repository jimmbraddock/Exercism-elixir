defmodule DNA do

  @transcribe %{?G=>?C, ?C=>?G, ?T=>?A, ?A=>?U}

  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, fn x -> @transcribe[x] end)
  end

end

