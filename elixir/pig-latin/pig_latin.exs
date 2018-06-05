defmodule PigLatin do
  @vowels ["a", "e", "i", "o", "u"]
  @vowel_clusters ["xr", "yt"]
  @double_clusters ["ch", "sh", "qu", "sq", "th"]
  @triple_clusters ["thr", "sch", "squ"]
  @consonants [
    "b",
    "c",
    "d",
    "f",
    "g",
    "h",
    "j",
    "k",
    "l",
    "m",
    "n",
    "p",
    "q",
    "r",
    "s",
    "t",
    "v",
    "w",
    "x",
    "y",
    "z"
  ]

  @x_and_y ["x", "y"]

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".
  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.
  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".
  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    # splits strings at whitespace
    |> String.split()
    # passes each word into translate function then returns an array
    |> Enum.map(&translate_word/1)
    # Joins enumerables into a string and seperates them with a whitespace
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    # cond returns the first one that is true 

    cond do
      # adds ay to end of word starting with vowel
      String.starts_with?(word, @vowels) ->
        word <> "ay"

      # adds ay to the end of word with vowel clusters 
      String.starts_with?(word, @vowel_clusters) ->
        word <> "ay"

      # word starts with a triple cluster and its moved back behind the vowels
      String.starts_with?(word, @triple_clusters) ->
        {cluster, rest} = String.split_at(word, 3)
        rest <> cluster <> "ay"

      # same as previous but with 2 vowel clusters 
      String.starts_with?(word, @double_clusters) ->
        {cluster, rest} = String.split_at(word, 2)
        rest <> cluster <> "ay"

      # check to see if word starts with x or y then start that function
      String.starts_with?(word, @x_and_y) ->
        # call x_y function
        x_y(word)

      # default value for words that dont start with a vowel, or a cluster, or x/y
      true ->
        # call recursive consonant function
        consonant_fun(word)
    end
  end

  defp consonant_fun(word) do
    # breaks the word up further if consonants follow the first consonant 
    cond do
      String.starts_with?(word, @consonants) ->
        {first, rest} = String.split_at(word, 1)
        # puts the consonant at the end of the word, "ay" is concatonated on later
        new = rest <> first
        consonant_fun(new)

      true ->
        # once the word no longer starts with a consonant, "ay" can be added on
        word <> "ay"
    end
  end

  defp x_y(word) do
    {first, rest} = String.split_at(word, 1)

    cond do
      # if a consonant follows x/y, it is treaded as a vowel
      String.starts_with?(rest, @consonants) ->
        word <> "ay"

      # if a vowel follows x/y, it is treated as a consonant  
      String.starts_with?(rest, @vowels) ->
        rest <> first <> "ay"

      # hopefully this default never takes place
      true ->
        "hope fully this never prints"
    end
  end
end

# Geordie 
