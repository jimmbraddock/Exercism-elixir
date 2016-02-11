defmodule Graph do
  defstruct attrs: [], nodes: [], edges: []
end

defmodule Dot do
  alias Graph, as: G

  defmacro graph(ast) do
    ast |> parse(%G{}) |> Macro.escape
  end

  defp parse([do: nil], graph), do: graph
  defp parse([do: {:__block__, _, ast}], graph), do: parse(ast, graph)
  defp parse([do: ast], graph), do: parse(ast, graph)
  defp parse([], graph), do: graph
  defp parse([h|t], graph), do: parse(h, parse(t, graph))
  defp parse({:graph, _, nil}, graph), do: graph
  defp parse({:graph, _, [[]]}, graph), do: graph
  defp parse({:graph, _, [[{k, v}]]}, graph), do: merge_attrs({k, v}, graph)
  defp parse({node, _, nil}, graph), do: merge_nodes(node, [], graph)
  defp parse({node, _, [[]]}, graph), do: merge_nodes(node, [], graph)
  defp parse({node, _, [[{attr ,attr_value}]]}, graph), do: merge_nodes(node, [{attr, attr_value}], graph)
  defp parse({:--, _, [{n1,_,_}, {n2, _, nil}]}, graph), do: merge_edges(n1, n2, [], graph)
  defp parse({:--, _, [{n1,_,_}, {n2, _, [[]]}]}, graph), do: merge_edges(n1, n2, [], graph)
  defp parse({:--, _, [{n1,_,_}, {n2, _, [[{attr, val}]]}]}, graph), do: merge_edges(n1, n2, [{attr, val}], graph)
  defp parse(_, _), do: raise ArgumentError


  defp merge_attrs(new_attr, graph=%G{attrs: attrs}), do: %G{graph|attrs: Enum.sort([new_attr|attrs])} 
  defp merge_nodes(node, new_attr, graph=%G{nodes: nodes}), do: %G{graph|nodes: Enum.sort([{node, new_attr}|nodes])} 
  defp merge_edges(n1, n2, attr, graph=%G{edges: edges}), do: %G{graph|edges: Enum.sort([{n1, n2, attr}|edges])} 
end