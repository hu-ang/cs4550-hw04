defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    #assuming that expr will have spaces between tokens
    |> String.split(~r/\s+/)
    |> Enum.map(&tag_tokens/1)
    |> to_postfix([])
    |> eval([])

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end


  def tag_tokens(str) do
    case Float.parse(str) do
        {x, _} -> {:num, x}
        :error -> {:op, str}
    end
  end

  def to_postfix([], ops) do 
    Enum.reverse ops
  end
  
  def to_postfix([head | tail], ops) do
    case head do
      {:num, value} -> [head | to_postfix(tail, ops)]
      {:op, o} -> 
        cond do
          ops == [] -> to_postfix(tail, [head])
          morePriority(o, hd(ops)) -> to_postfix(tail, [head | ops])
        true ->
          [first | rest] = ops
          [first | to_postfix(tail, [head | rest])]
        end
    end
  end

  def morePriority(new, curr) do
    #!((new === "+" || new === "-") && (curr === "/" || curr === "*"))
    cond do 
      ((new === "+" || new === "-") && (curr === "/" || curr === "*")) -> false
      ((new === "/" || new === "*") && (curr === "+" || curr === "-")) -> true
      true -> false
    end

  end

  def eval([], [x]) do
    x
  end

  def eval([head | tail], acc) do
    case head do 
      {:num, n} -> eval(tail, [n | acc])
      {:op, "+"} -> 
        [first | [second | rest]] = acc
        eval(tail, [first + second | rest])
      {:op, "-"} -> 
        [first | [second | rest]] = acc
        eval(tail, [first - second | rest])
      {:op, "*"} -> 
        [first | [second | rest]] = acc
        eval(tail, [first * second | rest])
      {:op, "/"} -> 
        [first | [second | rest]] = acc
        eval(tail, [first / second | rest])
    end
  end


end
