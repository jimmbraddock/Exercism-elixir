defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @error_equality {:error, "side lengths violate triangle inequality"}
  @error_negative {:error, "all side lengths must be positive"}

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }

  def kind(a, b, c) when a<=0 or b<=0 or c <=0, do: @error_negative
  def kind(a, b, c) when a+b <= c or a+c <= b or b+c <= a, do: @error_equality
  def kind(a, a, a), do: {:ok, :equilateral}
  def kind(a, _, a), do: {:ok, :isosceles}
  def kind(a, a, _), do: {:ok, :isosceles}
  def kind(_, a, a), do: {:ok, :isosceles}
  def kind(_, _, _), do: {:ok, :scalene}

end
