defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    plaintext
    |> String.downcase
    |> String.replace(~r/[^\w\d]/, "")
    |> String.graphemes
    |> encode([])
    |> Enum.chunk(5, 5, [])
    |> Enum.map(&Enum.join(&1, ""))
    |> Enum.join(" ") 
  end

  defp encode([], acc), do: acc
  defp encode([h|t], acc) do
      encode(t, acc ++ [convert(h)])
  end

  def convert(_=<<nb>>) when nb >= 97 and nb <= 122, do: <<219 - nb>>
  def convert(n), do: n

end


