defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest. 
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    number
    |> factorize(2, [])
  end

  defp factorize(number, factor, prime_factors) when number < factor, do: prime_factors
  defp factorize(number, factor, prime_factors) when rem(number, factor) == 0 do
    [factor|factorize(div(number, factor), factor, prime_factors)]
  end
  defp factorize(number, factor, prime_factors) do
    number
    |> factorize(factor + 1, prime_factors)
  end

end