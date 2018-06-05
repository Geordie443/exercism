defmodule TwelveDays do
  # custom type day
  @type day ::
          :first
          | :second
          | :third
          | :fourth
          | :fifth
          | :sixth
          | :seventh
          | :eighth
          | :ninth
          | :tenth
          | :eleventh
          | :twelfth
  # matching day with the word associated with it
  @day_word %{
    first: "first",
    second: "second",
    third: "third",
    fourth: "fourth",
    fifth: "fifth",
    sixth: "sixth",
    seventh: "seventh",
    eighth: "eighth",
    ninth: "ninth",
    tenth: "tenth",
    eleventh: "eleventh",
    twelfth: "twelfth"
  }

  # assigning a gift to a day
  @gift %{
    first: "a Partridge in a Pear Tree",
    second: "two Turtle Doves",
    third: "three French Hens",
    fourth: "four Calling Birds",
    fifth: "five Gold Rings",
    sixth: "six Geese-a-Laying",
    seventh: "seven Swans-a-Swimming",
    eighth: "eight Maids-a-Milking",
    ninth: "nine Ladies Dancing",
    tenth: "ten Lords-a-Leaping",
    eleventh: "eleven Pipers Piping",
    twelfth: "twelve Drummers Drumming"
  }

  # associating a number with a day atom
  @number %{
    1 => :first,
    2 => :second,
    3 => :third,
    4 => :fourth,
    5 => :fifth,
    6 => :sixth,
    7 => :seventh,
    8 => :eighth,
    9 => :ninth,
    10 => :tenth,
    11 => :eleventh,
    12 => :twelfth
  }

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    day = @number[number]
    day_num = @day_word[day]
    present = @gift[day]

    # cond statement that determines its only the first day or more than the first day
    cond do
      number == 1 ->
        verse =
          "On the " <> day_num <> " day of Christmas my true love gave to me, " <> present <> "."

        verse

      number > 1 ->
        song =
          "On the " <> day_num <> " day of Christmas my true love gave to me, " <> present <> ", "

        # uses private function to build out the string for the rest of the verse
        verse = verse_builder(number - 1, song)
    end
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    initial = starting_verse
    final = ending_verse

    verse = ""

    # builds the verse for starting at specified day
    new_verse =
      for day <- initial..final do
        verse = verse <> TwelveDays.verse(day)
      end

    # a bit of tweaking to build the final verse
    final =
      List.to_string(new_verse)
      |> String.replace(~r/(\.)/, ".\n")
      |> String.slice(0..-2)

    final
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    # just calls verses witht he range of all 12 days
    TwelveDays.verses(1, 12)
  end

  defp verse_builder(number, verse) when number > 1 do
    # gets the strings needed to build the verse
    day = @number[number]
    day_num = @day_word[day]
    present = @gift[day]

    # gets the part of the song then recursively calls itself to build out the rest of the verse
    song = verse <> present <> ", "
    verse = verse_builder(number - 1, song)
  end

  defp verse_builder(number, verse) when number == 1 do
    day = @number[number]
    day_num = @day_word[day]
    present = @gift[day]
    # case for the last entry
    song = verse <> "and " <> present <> "."
    song
  end
end

# Geordie 
