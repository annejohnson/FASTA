defmodule FASTA do
  @moduledoc """
  Provides a function `FASTA.valid_string?/1` to indicate if a string is a valid
  FASTA-formatted string.
  """

  @doc """
  Returns true if a string is a valid FASTA-formatted string.

  ## Parameters

    - `str`: string to check for FASTA formatting

  ## Example

      iex> FASTA.valid_string?("> Acer rubrum
      ...>                      GGTCGAACTGATG")
      true

      iex> FASTA.valid_string?("> Acer rubrum")
      false
  """
  def valid_string?(str) do
    str
    |> FASTA.Parser.parse
    |> Enum.any?
  end
end
