defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    String.to_charlist(text)
    |> cipher(shift) 
    |> List.to_string()
  end

  defp cipher(charlist, shift), do: cipher(charlist, shift, [])
  defp cipher([ head | tail ], shift, ciphertext), do: cipher(tail, shift, ciphertext ++ [transform(head, shift)])
  defp cipher([], _, ciphertext), do: ciphertext

  defp transform(char, rotation) when char in ?a..?z, do: rem((char - ?a + rotation), 26) + ?a
  defp transform(char, rotation) when char in ?A..?Z, do: rem((char - ?A + rotation), 26) + ?A
  defp transform(char, _), do: char
  
end
