defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    cond do
      Regex.run(~r/([^ACGU])/, rna) == nil ->
        codon_list = for <<x::binary-3 <- rna>>, do: x

        protein_map_list =
          Enum.map(codon_list, fn x ->
            ProteinTranslation.of_codon(x)
          end)

        size = Enum.count(protein_map_list)

        protein_list = []

        protein_list =
          for x <- 0..(size - 1) do
            new_protein = ProteinTranslation.protein_return(x, protein_map_list)
            protein_list ++ new_protein
          end

        protein_string = List.to_string(protein_list)

        new_protein_string =
          protein_string
          |> String.replace(~r/(STOP)(.*)()/, "")
          |> String.split()

        {:ok, new_protein_string}

      Regex.run(~r/([^ACGU])/, rna) != nil ->
        {:error, "invalid RNA"}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    # in_codon = codon
    # the_protein = "Methionine"

    # translation_map =  %{codon: in_codon, protein: the_protein}

    protein_maps = [
      %{codon: "UGU", protein: "Cysteine"},
      %{codon: "UGC", protein: "Cysteine"},
      %{codon: "UUA", protein: "Leucine"},
      %{codon: "UUG", protein: "Leucine"},
      %{codon: "AUG", protein: "Methionine"},
      %{codon: "UUU", protein: "Phenylalanine"},
      %{codon: "UUC", protein: "Phenylalanine"},
      %{codon: "UCU", protein: "Serine"},
      %{codon: "UCC", protein: "Serine"},
      %{codon: "UCA", protein: "Serine"},
      %{codon: "UCG", protein: "Serine"},
      %{codon: "UGG", protein: "Tryptophan"},
      %{codon: "UAU", protein: "Tyrosine"},
      %{codon: "UAC", protein: "Tyrosine"},
      %{codon: "UAA", protein: "STOP"},
      %{codon: "UAG", protein: "STOP"},
      %{codon: "UGA", protein: "STOP"}
    ]

    # if translation_map.codon == "AUG" do
    # {:ok, translation_map.protein}
    # end

    cond do
      Regex.run(~r/([^ACGU])/, codon) == nil ->
        returned_map = ProteinTranslation.map_match(protein_maps, codon)
        returned_protein = returned_map.protein
        {:ok, returned_protein}

      Regex.run(~r/([^ACGU])/, codon) != nil ->
        {:error, "invalid codon"}
    end
  end

  def map_match(array, codon) do
    test_map = %{codon: codon, protein: ""}

    Enum.find(array, fn protein_map ->
      test_map.codon == protein_map.codon
    end)
  end

  def protein_return(index, array) do
    {:ok, protein} = Enum.at(array, index)
    string = "#{protein} "
    string
  end
end
