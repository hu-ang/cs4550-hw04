defmodule PracticeWeb.PageController do
  use PracticeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def double(conn, %{"x" => x}) do
    {x, _} = Integer.parse(x)
    y = Practice.double(x)
    render conn, "double.html", x: x, y: y
  end

  def calc(conn, %{"expr" => expr}) do
    y = Practice.calc(expr)
    render conn, "calc.html", expr: expr, y: inspect(y)
  end

  def factor(conn, %{"x" => x}) do
    {x, _} = Integer.parse(x)
    y = Practice.factor(x)
    render conn, "factor.html", x: x, y: inspect(y)
  end

  def palindrome(conn, %{"p" => p}) do
    q = Practice.palindrome?(p)
    render conn, "palindrome.html", p: p, q: q
  end
end

