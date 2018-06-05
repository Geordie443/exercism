defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  # expects a whole map as a return
  # this exercise is good for map updating
  @spec count(String.t()) :: map
  def count(sentence) do
    filtered_sentence =
      sentence
      # make all letters lowercase 
      |> String.downcase()
      # Split string on any of the following characters
      |> String.split([" ", "_", ",", "?", "!", ":"])
      # since the string is now an array or characters, enum can be utilized
      # enum.filter will return elements where the function only returns a truthy value 
      # the first arguement is piped into filter and the function is the regex function which is being captured
      # Regex.run will return a truthy value on strings that contain whatever is being put into regex
      # this regex will return as true if the enumerable contains letters or numbers only
      # entries in the array without numbers or letters are removed
      |> Enum.filter(&Regex.run(~r/[\w\d]+/, &1))

    # reduce(enumerable, accumulator, function)
    final_map =
      Enum.reduce(filtered_sentence, %{}, fn word, word_map ->
        # determines if a word exists in the map
        # has_key?(map, key)
        if Map.has_key?(word_map, word) do
          # if the key exists, the map gets updated
          # update!(map, key, fun)
          Map.update!(word_map, word, &(&1 + 1))
        else
          # Map.put(map, key, value)
          # puts the given value (1) for the key in map
          Map.put(word_map, word, 1)
        end
      end)

    final_map
  end
end

# Geordie
