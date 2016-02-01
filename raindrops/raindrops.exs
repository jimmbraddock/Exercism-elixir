defmodule Raindrops do
 
@t ["Pling": 3, "Plang": 5, "Plong": 7]

  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    raindrop = prime_to_string(number)
    if raindrop == "" do
      to_string(number)
    else 
      raindrop
    end
  end

  defp prime_to_string(n) do
    Enum.reduce(@t, "", fn ({w, p}, acc) when rem(n, p) == 0 ->
        acc <> to_string(w)
      (_, acc) -> 
        acc
    end)
  end 
end
