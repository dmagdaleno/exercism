defmodule ProteinTranslation do
  @codon_protein %{
    UGU: "Cysteine", 
    UGC: "Cysteine", 
    UUA: "Leucine",
    UUG: "Leucine",
    AUG: "Methionine",
    UUU: "Phenylalanine",
    UUC: "Phenylalanine",
    UCU: "Serine",
    UCC: "Serine",
    UCA: "Serine",
    UCG: "Serine",
    UGG: "Tryptophan",
    UAU: "Tyrosine",
    UAC: "Tyrosine",
    UAA: "STOP",
    UAG: "STOP",
    UGA: "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    get_codon_list(rna)
    |> get_protein_list
  end

  defp get_codon_list(rna) do 
    get_codon_list([], String.split_at(rna, 3))
  end

  defp get_codon_list(codon_list, {codon, _ = ""}), do: Enum.reverse([codon | codon_list])

  defp get_codon_list(codon_list, {codon, rna}) do 
    get_codon_list([codon | codon_list], String.split_at(rna, 3))
  end

  defp get_protein_list([head | tail]), do: get_protein_list([], of_codon(head), tail)

  defp get_protein_list(protein_list, {_, _ = "STOP"}, _) do 
    get_reversed_protein_list(protein_list)
  end

  defp get_protein_list(protein_list, {_ = :ok, protein}, [head | tail]) do 
    get_protein_list([protein | protein_list], of_codon(head), tail)
  end

  defp get_protein_list(_, {_ = :error, _}, _), do: {:error, "invalid RNA"}

  defp get_protein_list(protein_list, {_, protein}, []) do 
    get_reversed_protein_list([protein | protein_list])
  end

  defp get_reversed_protein_list(protein_list) do 
    {:ok, Enum.reverse(protein_list)}
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
    protein = @codon_protein[String.to_atom(codon)]
    if protein do
      {:ok, protein}
    else
      {:error, "invalid codon"}
    end
  end
end
