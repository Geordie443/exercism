defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_s, _size) do
    # gets the length 
    string_size = String.length(_s)

    # conditional statement determining whether or not the string needs to be broken up
    cond do
      # if size less than one or size is greater than that of the string, []
      _size < 1 || _size > string_size ->
        []

      # if size is less than string size then break up the string
      _size <= string_size ->
        string_splitter(_s, _size)
    end
  end

  # splits the string and builds the list from an accumulator 
  defp string_splitter(string, split, accumulator \\ []) do
    length = String.length(string)

    cond do
      # if the remaining length is greater than the split size
      length > split ->
        # cut is the part needing to be accumulated
        {cut, remaining} = String.split_at(string, split)
        # rest is the remainder of the string aside from the first which is removed
        {first, rest} = String.split_at(string, 1)
        # cut is added to the accumulator
        accumulator = accumulator ++ [cut]
        # rest is evaluated recursively
        string_splitter(rest, split, accumulator)

      # if the split size is same as length, indicating that this is the last entry
      length == split ->
        accumulator ++ [string]
    end
  end
end
