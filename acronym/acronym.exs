defmodule Acronym do
  @doc """
  Generate an acronym from a string. 
  "This is a string" => "TIAS"
  """
  @spec abbreviate(string) :: String.t()
  def abbreviate(string) do
    Regex.scan(~r/([A-Z]|\s\w)/, string)
     |> Enum.reduce("", fn x, acc -> acc <> hd(x) end)
     |> String.upcase
     |> String.replace(" ", "")
  end
end
