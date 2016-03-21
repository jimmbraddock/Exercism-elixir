defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string
      |> String.codepoints
      |> calc("", 1)
  end

  defp calc([], acc, _), do: acc
  defp calc([h|[]], acc, current_count), do: acc <> Integer.to_string(current_count) <> h 
  defp calc([h|t], acc, current_count) do
    if h == hd(t) do
      calc(t, acc, current_count + 1)
    else
      calc(t, acc <> Integer.to_string(current_count) <> h, 1)
    end
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    Regex.scan(~r/[0-9]+[A-z]/, string)
    |> Enum.reduce("", fn x, acc ->
      counts = x
              |> Enum.join
              |> String.replace( ~r/[A-z]+/, "")
              |> String.to_integer
      word = x
              |> Enum.join
              |> String.replace( ~r/[0-9]+/, "")
      acc = acc <> Enum.join(for i <- 1..counts, do: word)
    end)
  end
end
