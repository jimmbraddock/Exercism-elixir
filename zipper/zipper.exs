defmodule BinTree do
  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{ value: any, left: BinTree.t | nil, right: BinTree.t | nil }
  defstruct value: nil, left: nil, right: nil
end

defmodule Zipper do

  defstruct focused: nil, trail: [], root: nil

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BT.t) :: Z.t
  def from_tree(bt) do
    %Zipper{focused: bt, root: bt}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t) :: BT.t
  def to_tree(%Zipper{root: tree}) do
    tree
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t) :: any
  def value(%Zipper{focused: node}) do
    node.value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Z.t) :: Z.t | nil
  def left(z=%Zipper{focused: %BinTree{left: nil}, trail: trail}), do: nil
  def left(z=%Zipper{focused: node, trail: trail}) do
    %Zipper{z | focused: node.left, trail: [:left|trail]}
  end
  
  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t) :: Z.t | nil
  def right(z=%Zipper{focused: %BinTree{right: nil}, trail: trail}), do: nil
  def right(z=%Zipper{focused: node, trail: trail}) do
    %Zipper{z | focused: node.right, trail: [:right|trail]}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t) :: Z.t
  def up(z) do
    %Zipper{z | focused: _up(z.root, Enum.reverse(z.trail))}
  end

  defp _up(tree, []), do: nil 
  defp _up(tree, [:left]), do: tree
  defp _up(tree, [:right]), do: tree
  defp _up(tree, [:right|trail]), do: _up(tree.right, trail)
  defp _up(tree, [:left|trail]), do: _up(tree.left, trail)
  

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t, any) :: Z.t
  def set_value(z=%Zipper{focused: node}, v) do
    new_focus = %BinTree{node | value: v}
    %Zipper{z|focused: new_focus, root: rebuild(z.root, Enum.reverse(z.trail), new_focus)}
  end

  defp rebuild(tree, [], new_subtree), do: new_subtree
  defp rebuild(tree, [:left], new_subtree), do: %BinTree{tree | left: new_subtree}
  defp rebuild(tree, [:right], new_subtree), do: %BinTree{tree | right: new_subtree}
  defp rebuild(tree, [:left|trail], new_subtree), do: rebuild(tree.left, trail, new_subtree)
  defp rebuild(tree, [:right|trail], new_subtree), do: rebuild(tree.right, trail, new_subtree)
  
  @doc """
  Replace the left child tree of the focus node. 
  """
  @spec set_left(Z.t, BT.t) :: Z.t
  def set_left(z=%Zipper{focused: node}, l) do
    new_focus = %BinTree{node | left: l}
    %Zipper{z|focused: new_focus, root: rebuild(z.root, Enum.reverse(z.trail), new_focus)}
  end
  
  @doc """
  Replace the right child tree of the focus node. 
  """
  @spec set_right(Z.t, BT.t) :: Z.t
  def set_right(z=%Zipper{focused: node}, r) do
    new_focus = %BinTree{node | right: r}
    %Zipper{z|focused: new_focus, root: rebuild(z.root, Enum.reverse(z.trail), new_focus)}
  end
end
