defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """
  # the accumulate function returns a list
  @spec accumulate(list, (any -> any)) :: list
  # apply(fun, args)

  # this accumulate is /2 and only occurs when the list passed to it is blank
  def accumulate([], fun) do
    []
  end

  # this accumulate is also /2 and will be the first accumulate function that a list is passed to
  # if it has elements present
  def accumulate(list, fun) do
    # breaks down the input into a head element and a tail list
    # head | [tail]
    [head | tail] = list

    # this accumulator variable is set to be the list value of head once fun has been applied to it
    accumulator = [apply(fun, [head])]
    # accumulate is recursively called with /3 this time so it has access to an accumulator 
    accumulate(tail, fun, accumulator)
  end

  # this accumulate occurs when the function is also passed an accumulator list
  def accumulate(list, fun, accumulator) do
    [head | tail] = list
    new = [apply(fun, [head])]
    # adding the new head to the list of heads that have already gone through the function
    accumulator = accumulator ++ new

    # since a list of 1 element will become head and leave a blank tail, this if statement is 
    # true when the final head has been evaluated and added to the accumulator

    if tail == [] do
      accumulator

      # if the end of the list has not yet been reached, the function is once again called recursively with the new accumulator  
    else
      accumulate(tail, fun, accumulator)
    end
  end
end

# Geordie 
