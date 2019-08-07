defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    count(strand, nucleotide, 0)
  end

  defp count([], _, acc), do: acc

  defp count([_ = nucleotide | tail], nucleotide, acc), do: count(tail, nucleotide, acc + 1)

  defp count([_ | tail], nucleotide, acc), do: count(tail, nucleotide, acc)
    

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do

    count_each = fn item -> {item, count(strand, item)} end

    @nucleotides
    |> Enum.map(count_each)
    |> Map.new
    
  end
end
