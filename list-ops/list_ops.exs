defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.
  def count_acc([], acc), do: acc
  def count_acc([h|t], acc) do
    count_acc(t, acc + 1)
  end

  @spec count(list) :: non_neg_integer
  def count(l) do
    count_acc(l, 0)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    reverse(l, [])
  end

  def reverse([], l), do: l
  def reverse([h|t], l) do
    reverse(t, [h | l])
  end

  @spec map(list, (any -> any)) :: list
  def map([], f), do: []
  def map([h|t], f) do
    [f.(h) | map(t, f)]
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], f), do: []
  def filter([h|t], f) do
    if f.(h) do
      [h | filter(t, f)]
    else
      filter(t, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, f), do: acc
  def reduce([h|t], acc, f) do
    reduce(t, f.(h, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    a |> reverse |> append_acc(b)
  end

  def append_acc([] ,l), do: l
  def append_acc([h|t], l) do
    append_acc(t, [h|l])
  end

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([h|t]) do
    append(h, concat(t))
  end

end