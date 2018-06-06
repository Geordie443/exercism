defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    # creates a list out of strings splitting the string on the listed characters
    |> String.split([" ", "-", ","])
    # eliminates all strings that dont contain word characters
    |> Enum.filter(&Regex.run(~r/[\w]+/, &1))
    # returns array with each element of list being passed into function
    |> Enum.map(&get_important_letters/1)
    # flattens list to remove all nested list
    |> List.flatten()
    # joins elements of list to a string
    |> Enum.join()
    # makes string uppercase 
    |> String.upcase()
  end

  # gets the first letter of a string , as well as any important follow up letter 
  defp get_important_letters(word) do
    # splits the string at 1 and assings it to be 2 different strings, the first letter and the rest of the string
    {first_letter, the_rest} = String.split_at(word, 1)

    # evaluates the rest of the string using regex to see if it contains another capitol letter, meaning it would need to be broken up again
    second_letter = Regex.run(~r/[A-Z]/, the_rest)

    # if there is a second letter, it returns both, otherwise just the first letter
    if second_letter do
      [first_letter] ++ [second_letter]
    else
      first_letter
    end
  end
end

# Geordie
