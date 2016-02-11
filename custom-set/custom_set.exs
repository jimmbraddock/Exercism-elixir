defmodule CustomSet do
  # This lets the compiler check that all list callback functions have been
  # implemented.
  @behaviour Set

  defstruct list: []

  def delete(t, value), do: new(Enum.filter(t.list, &(&1 !== value)))

  def difference(t1, t2), do: new(t1.list -- t2.list)

  def disjoint?(t1, t2), do: size(intersection(t1,t2)) == 0

  def equal?(t1, t2), do: Enum.sort(t1.list) === Enum.sort(t2.list)

  def intersection(t1, t2), do: new(Enum.filter(t1.list, &(member?(t2, &1))))

  def member?(t, value), do: value in t.list

  def put(t=%CustomSet{list: values}, value), do: new([value|values])
  
  def empty(_), do: new()
  
  def new(),   do: %CustomSet{}
  def new([]), do: %CustomSet{}
  def new(l), do: %CustomSet{list: l |> Enum.uniq |> Enum.sort}

  def size(t), do: length(t.list)

  def subset?(t1, t2), do: Enum.all?(t1.list, &(member?(t2, &1)))

  def to_list(t), do: Enum.sort(t.list)

  def union(t1, t2), do: new(t1.list ++ t2.list)
end
