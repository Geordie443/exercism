defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    construct = []
    # passes the list, the empty list to be built, and the function for a bool value
    final = Strain.listbuilderKeep(list, construct, fun)
    final
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    construct = []
    final = Strain.listbuilderDiscard(list, construct, fun)
    final
  end

  def listbuilderKeep(list, build, fun) when length(list) == 0 do
    []
  end

  def listbuilderKeep(list, build, fun) when length(list) == 1 do
    [last] = list

    newbuild =
      if fun.(last) == true do
        build ++ [last]
      else
        build
      end

    newbuild
  end

  def listbuilderKeep(list, build, fun) do
    [head | tail] = list

    newbuild =
      if fun.(head) == true do
        build ++ [head]
      else
        build
      end

    # IO.puts(newbuild)
    Strain.listbuilderKeep(tail, newbuild, fun)
  end

  def listbuilderDiscard(list, build, fun) when length(list) == 0 do
    []
  end

  def listbuilderDiscard(list, build, fun) when length(list) == 1 do
    [last] = list

    newbuild =
      if fun.(last) == false do
        build ++ [last]
      else
        build
      end

    newbuild
  end

  def listbuilderDiscard(list, build, fun) do
    [head | tail] = list

    newbuild =
      if fun.(head) == false do
        build ++ [head]
      else
        build
      end

    # IO.puts(newbuild)
    Strain.listbuilderDiscard(tail, newbuild, fun)
  end
end

# Geordie 
