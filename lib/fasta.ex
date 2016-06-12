defmodule FASTA do
  @moduledoc """
  Provides functions for validating and parsing FASTA-formatted strings.

  A FASTA string contains one or more pieces of sequence data. Each piece of data
  consists of a header line starting with the `>` character, followed by one or more
  lines of sequence characters.

  [Learn more about the FASTA format here](https://en.wikipedia.org/wiki/FASTA_format).
  """

  @doc """
  Returns true if a string is a valid FASTA-formatted string.

  ## Parameters

    - `fasta_string`: string to check for FASTA formatting

  ## Examples

      iex> FASTA.valid_string?("> Acer rubrum
      ...>                      GGTCGAACTGATG")
      true

      iex> FASTA.valid_string?("> Acer rubrum")
      false
  """
  def valid_string?(fasta_string) do
    fasta_string
    |> FASTA.Parser.parse
    |> Enum.any?
  end

  @doc """
  Parses a FASTA string into a list of FASTA data.

  Each returned `FASTA.Datum` struct responds to:

    - `header/0`: returns the header line, stripped of the `>` character and leading
      and trailing whitespace characters
    - `sequence/0`: returns the sequence, stripped of whitespace characters

  ## Parameters

    - `fasta_string`: FASTA-formatted string to parse

  ## Example

      iex> fasta_string = "> locus6 | Gorilla gorilla
      ...>                 ATCGTCGCTGATAGCTGCATCAG
      ...>
      ...>                 > locus7 | Gorilla gorilla
      ...>                 TGGGCTGCTATGCGGATGCAGAT"
      ...> FASTA.parse_string(fasta_string)
      [
        %FASTA.Datum{header: "locus6 | Gorilla gorilla", sequence: "ATCGTCGCTGATAGCTGCATCAG"},
        %FASTA.Datum{header: "locus7 | Gorilla gorilla", sequence: "TGGGCTGCTATGCGGATGCAGAT"}
      ]
  """
  def parse_string(fasta_string) do
    FASTA.Parser.parse(fasta_string)
  end
end
