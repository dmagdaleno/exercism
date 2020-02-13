defmodule SecretHandshake do
  use Bitwise
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    []
    |> handshake(code &&& 0b00001)
    |> handshake(code &&& 0b00010)
    |> handshake(code &&& 0b00100)
    |> handshake(code &&& 0b01000)
    |> handshake(code &&& 0b10000)
  end

  defp handshake(commands, 1), do: commands ++ ["wink"]
  defp handshake(commands, 2), do: commands ++ ["double blink"]
  defp handshake(commands, 4), do: commands ++ ["close your eyes"]
  defp handshake(commands, 8), do: commands ++ ["jump"]
  defp handshake(commands, 16), do: Enum.reverse(commands)
  defp handshake(commands, _), do: commands
end
