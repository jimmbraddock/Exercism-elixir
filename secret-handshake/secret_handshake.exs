defmodule SecretHandshake do
    use Bitwise
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  @secret  [
    {"jump" , 8},
    { "close your eyes" , 4},
    { "double blink" , 2},
    {"wink" , 1}
  ]

  @spec decode(non_neg_integer) :: [String.t]
  def decode(flags) do
    Enum.reduce(@secret, [], fn {k, v}, acc
        when (flags &&& v) != 0 -> [k|acc]
        (_, acc) -> acc
      end
    )
  end

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) when code > 16,  do: code |> decode |> Enum.reverse
  def commands(code), do: code |> decode

end
