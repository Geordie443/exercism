defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  # typespec describing expected return value
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    # converts array of characters to string
    strandString = List.to_string(strand)

    case nucleotide do
      ?A ->
        # breaks string on every instance of "A" then subtracts 1 to get the accurate count of times A occured
        count = length(String.split(strandString, "A")) - 1

      ?C ->
        count = length(String.split(strandString, "C")) - 1

      ?G ->
        count = length(String.split(strandString, "G")) - 1

      ?T ->
        count = length(String.split(strandString, "T")) - 1
    end

    count
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    # utilizes the def for count to get the count of each nucleotide
    countA = NucleotideCount.count(strand, ?A)
    countC = NucleotideCount.count(strand, ?C)
    countG = NucleotideCount.count(strand, ?G)
    countT = NucleotideCount.count(strand, ?T)
    # maps the counts of each nucleotide
    histogram_map = %{?A => countA, ?T => countT, ?C => countC, ?G => countG}
    histogram_map
  end
end

# Geordie
