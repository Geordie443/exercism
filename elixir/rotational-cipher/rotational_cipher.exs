defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    # list that converts input string to charlist 'list'
    list = String.to_charlist(text)
    # Enum map enumerates through the list and puts each item through the function
    Enum.map(list, &shifter(&1, shift))
    # after enum runs each list item through the shifter function, it puts the items bakc into a string
    |> List.to_string()
  end

  # takes a character and a number to shift it by then shifts it to a different ascii value
  defp shifter(ch, n) do
    case ch do
      # for ascii values in the range ?a..?z which is 97 to 122
      ch when ch in ?a..?z ->
        # shifts the value forward, the remainder is for rolling it back to the beginning when it goes over z
        new = rem(ch - ?a + n, 26) + ?a
        # returns the new shifted character
        new

      # ?A..Z? which is 65 to 90
      ch when ch in ?A..?Z ->
        new = rem(ch - ?A + n, 26) + ?A
        new

      _ ->
        # returns the same character that was input if it is not in a certain range
        ch
    end
  end
end

# Geordie
