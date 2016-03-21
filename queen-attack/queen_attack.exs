defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new(nil | list) :: Queens.t()
  def new([white: w, black: w]), do: raise ArgumentError
  def new, do: %Queens{black: {7, 3}, white: {0, 3}}
  def new([white: w, black: b]) do
    %Queens{black: b, white: w}
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens=%Queens{white: w, black: b}) do
    (0..7) |> Enum.map_join("\n", fn row ->
        (0..7) |> Enum.map_join(" ", fn col ->
          cond do
            {row, col} == w -> "W"
            {row, col} == b -> "B"
            true -> "_"
          end
        end)
    end)
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens=%Queens{white: {w_x, w_y}, black: {b_x, b_y}}) do
    cond do
      w_x == b_x or w_y == b_y or abs(w_x-b_x) == abs(w_y-b_y) -> true
      true -> false
    end
  end

end