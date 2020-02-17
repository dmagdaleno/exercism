defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    keep(list, fun, [])
  end

  defp keep([head | tail], predicate, selected) do
    if predicate.(head) do
      keep(tail, predicate, selected ++ [head])
    else
      keep(tail, predicate, selected)
    end
  end

  defp keep([], _, selected), do: selected

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    discard(list, fun, [])
  end

  defp discard([head | tail], predicate, selected) do
    if predicate.(head) do
      discard(tail, predicate, selected)
    else
      discard(tail, predicate, selected ++ [head])
    end
  end

  defp discard([], _, selected), do: selected
end
