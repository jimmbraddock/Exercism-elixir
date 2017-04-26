defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def keep(list, fun) do
      apply_func(list, fun, true)
  end

  defp apply_func(list, fun, required) do
      Enum.reduce(list, [], fn el, acc ->
          case apply(fun, [el]) == required do
              true -> [el|acc]
              _ -> acc
          end
      end) |> Enum.reverse
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def discard(list, fun) do
      apply_func(list, fun, false)
  end
end
