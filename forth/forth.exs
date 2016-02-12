defmodule Forth do
  @opaque evaluator :: any
  
  defstruct stack: [], word_parse?: false, words: %{}, currentdef: [], currentword: nil

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new() do
    %Forth{}
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t) :: evaluator
  def eval(ev, input) do
    Regex.split(~r/[^\p{L}\p{N}\p{S}\p{P}]+/u, input)
    |> Enum.reduce(ev, &parse/2)
  end

  defp parse(input, ev) do
    token = String.downcase(input)
    case ev.word_parse? do
      false -> common_parse(token, ev)
      true -> word_parse(token, ev)
    end
  end
  
  defp common_parse(token, ev) do
    cond do
      word?(token, ev) == true -> run_word(token, ev)
      Regex.match?(~r/\p{N}+/, token) -> %Forth{ev|stack: [String.to_integer(token) | ev.stack]}
      token == ":" -> define_word(ev)
      token == "-" -> subtraction(ev)
      token == "+" -> sum(ev)
      token == "/" -> division(ev)
      token == "*" -> multiplication(ev)
      token == "dup" -> duplicate(ev)
      token == "over" -> over(ev)
      token == "swap" -> swap(ev)
      token == "drop" -> drop(ev)
      true -> raise Forth.UnknownWord, token
    end
  end

  defp word?(token, ev), do: Map.has_key?(ev.words, token)

  defp run_word(token, ev) do
    ev.words[token] |> Enum.reduce(ev, &common_parse/2)
  end

  defp define_word(ev) do
    %Forth{ev|word_parse?: true, currentdef: [], currentword: nil}
  end

  defp word_parse(token, ev) do
    case ev.currentword do
      nil -> parse_word_name(token, ev)
      _ -> parse_word_def(token, ev)
    end
  end

  defp parse_word_name(token, ev) do
    cond do
      Regex.match?(~r/\p{N}+/, token) -> raise Forth.InvalidWord, token
      true -> %Forth{ev|currentword: token}
    end
  end

  defp parse_word_def(token, ev) do
    cond do
      token == ";" -> complete_word_parse(ev)
      true -> %Forth{ev|currentdef: [token | ev.currentdef] }
    end
  end

  defp complete_word_parse(ev) do
    new_words = Map.put(ev.words, ev.currentword, Enum.reverse(ev.currentdef))
    %Forth{ev|word_parse?: false, words: new_words}
  end

  defp subtraction(ev=%Forth{stack: l}) when length(l) < 2, do: raise Forth.StackUnderflow
  defp subtraction(ev=%Forth{stack: l=[h1, h2|t]}) do
    %Forth{ev|stack: [h2 - h1 | t]}
  end

  defp sum(ev=%Forth{stack: l}) when length(l) < 2, do: raise Forth.StackUnderflow
  defp sum(ev=%Forth{stack: l=[h1, h2|t]}) do
    %Forth{ev|stack: [h2 + h1 | t]}
  end 

  defp multiplication(ev=%Forth{stack: l}) when length(l) < 2, do: raise Forth.StackUnderflow
  defp multiplication(ev=%Forth{stack: l=[h1, h2|t]}) do
    %Forth{ev|stack: [h2 * h1 | t]}
  end  

  defp division(ev=%Forth{stack: l=[0|t]}), do: raise Forth.DivisionByZero
  defp division(ev=%Forth{stack: l=[h1, h2|t]}) do
    %Forth{ev|stack: [div(h2, h1) | t]}
  end

  defp duplicate(ev=%Forth{stack: stack}) when length(stack) < 1, do: raise Forth.StackUnderflow
  defp duplicate(ev=%Forth{stack: stack}) do
    %Forth{ev|stack: [hd(stack)|stack]}
  end

  
  defp drop(ev=%Forth{stack: stack}) when length(stack) < 1, do: raise Forth.StackUnderflow
  defp drop(ev=%Forth{stack: stack=[_|t]}) do
    %Forth{ev|stack: t}
  end

  defp over(ev=%Forth{stack: stack}) when length(stack) < 2, do: raise Forth.StackUnderflow
  defp over(ev=%Forth{stack: stack=[_, h2|tail]}) do
    %Forth{ev|stack: [h2|stack]}
  end

  defp swap(ev=%Forth{stack: stack}) when length(stack) < 2, do: raise Forth.StackUnderflow
  defp swap(ev=%Forth{stack: stack=[h1, h2|t]}) do
    %Forth{ev|stack: [h2, h1|t]}
  end      

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t
  def format_stack(ev) do
    ev.stack
    |> Enum.reverse
    |> Enum.join(" ")
  end

  defmodule StackUnderflow do
    defexception [:message]
    def exception(_), do: %StackUnderflow{message: "stack underflow"}
  end

  defmodule InvalidWord do
    defexception [:message]
    def exception(word), do: %InvalidWord{message: "invalid word: #{inspect word}"}
  end

  defmodule UnknownWord do
    defexception [:message]
    def exception(word), do: %UnknownWord{message: "unknown word: #{inspect word}"}    
  end

  defmodule DivisionByZero do
    defexception [:message]
    def exception(_), do: %DivisionByZero{message: "division by zero"}
  end
end