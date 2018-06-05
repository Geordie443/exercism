defmodule Bob do
  # array of letters to be compared against
  @letters [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    # weird characters
    "Х",
    "О",
    "Д",
    "И"
  ]

  def hey(input) do
    # different booleans to interpret whether or not the input is a question/ yelling/ silent
    cond do
      say_nothing?(input) -> "Fine. Be that way!"
      yell?(input) && question?(input) -> "Calm down, I know what I'm doing!"
      question?(input) -> "Sure."
      yell?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  # function which determines if it is a question by seeing if it ends in a question mark
  defp question?(input) do
    String.last(input) == "?"
  end

  # checks if they were yelling by comparing the capitolized version of the statement to itself after the removal of the first letter
  # another condition that checks to see if they are yelling is if it included actual letters and not just numbers
  defp yell?(input) do
    length = String.length(input)
    sliced = String.slice(input, 1..length)
    return = String.upcase(sliced) == sliced
    has_letter = String.contains?(sliced, @letters)
    final = return && has_letter
    final
  end

  # function that checks to see if the statement was silent
  defp say_nothing?(input) do
    String.trim(input) == ""
  end
end
