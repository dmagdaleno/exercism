defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, &parse/1)
  end

  defp parse(nucleotide) do
    case nucleotide do
      71 -> 67
      67 -> 71
      84 -> 65
      65 -> 85
    end
  end
end
