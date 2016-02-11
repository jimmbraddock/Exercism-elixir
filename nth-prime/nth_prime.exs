defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count < 1 or not is_integer(count), do: raise ArgumentError
  def nth(count) do
    get_next_prime(2, 1, count)
  end
  
  def get_next_prime(num, count, count), do: num
  def get_next_prime(num, acc, count) do
    cond do
        prime?(num) -> n = acc + 1
        true -> n = acc
    end
    if n == count do
        num
    else
        get_next_prime(num+1, n, count)
    end
  end

  defp prime?(num) do
    Enum.all?(2..num-1, &(rem(num, &1) != 0))
  end

end