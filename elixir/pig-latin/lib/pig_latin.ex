defmodule PigLatin do
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
    String.split(phrase, " ")
    |> translate_words
    |> String.trim
  end

  defp translate_words([head | tail]), do: to_pig_latin(head) <> " " <> translate_words(tail)

  defp translate_words([]), do: ""

  defp to_pig_latin(word) do
    case find_rule(word) do
      :rule1 -> apply_rule1(word)
      :rule2 -> apply_rule2(word)
      :rule3 -> apply_rule3(word)
      :rule4 -> apply_rule4(word)
    end
  end

  defp find_rule(word) do
    cond do
      String.starts_with?(word, ~w(a e i o u xb xr yt yd)) -> :rule1
      String.starts_with?(word, ~w(sch squ thr str)) -> :rule3
      String.starts_with?(word, ~w(th ch qu pl)) -> :rule4
      true -> :rule2
    end
  end

  defp apply_rule1(word), do: word <> "ay"

  defp apply_rule2(word) do
    [{_,index}] = Regex.run(~r/[bcdfghjklmnpqrstvwxyz]+/, word, return: :index)
    move_to_end(word, index)
    |> apply_rule1
  end

  defp apply_rule3(word) do
    move_to_end(word, 3)
    |> apply_rule1
  end

  defp apply_rule4(word) do
    move_to_end(word, 2)
    |> apply_rule1
  end

  defp move_to_end(word, index) do
    {start, finish} = String.split_at(word, index)
    finish <> start
  end
end
