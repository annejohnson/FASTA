defmodule FASTA.Parser do
  @moduledoc false

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
