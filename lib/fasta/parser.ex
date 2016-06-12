defmodule FASTA.Parser do
  @moduledoc """
  Provides a function `FASTA.Parser.parse/1` to extract a collection of data from
  a FASTA string.

  A FASTA string contains one or more pieces of sequence data. Each piece of data
  consists of a header line starting with the `>` character, followed by one or more
  lines of sequence characters.

  [Learn more about the FASTA format here](https://en.wikipedia.org/wiki/FASTA_format).
  """

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
      ...> FASTA.Parser.parse(fasta_string)
      [
        %FASTA.Datum{header: "locus6 | Gorilla gorilla", sequence: "ATCGTCGCTGATAGCTGCATCAG"},
        %FASTA.Datum{header: "locus7 | Gorilla gorilla", sequence: "TGGGCTGCTATGCGGATGCAGAT"}
      ]
  """
  def parse(fasta_string) do
    stripped_fasta_string = String.strip(fasta_string)
    data_strings = Regex.split(data_separator_regex, stripped_fasta_string)

    data_strings
    |> Parallel.filter(&valid_data_string?/1)
    |> Parallel.map(&parse_data_string/1)
  end

  defp data_separator_regex do
    ~r/\n+\s*(?=>)/
  end

  defp valid_data_string?(data_string) do
    String.contains?(data_string, "\n") && String.starts_with?(data_string, ">")
  end

  defp parse_data_string(data_string) do
    [header_string, sequence_string] = Regex.split(~r/\n/, data_string, parts: 2)

    header_str = clean_header(header_string)
    sequence_str = clean_sequence(sequence_string)

    %FASTA.Datum{header: header_str, sequence: sequence_str}
  end

  defp clean_header(raw_header) do
    raw_header
    |> String.lstrip(?>)
    |> String.strip
  end

  defp clean_sequence(raw_sequence) do
    Regex.replace(~r/\s+/, raw_sequence, "")
  end
end
