defmodule FASTATest do
  use ExUnit.Case
  doctest FASTA

  test "parse_string extracts data from a valid fasta string" do
    raw_valid_fastas = [
      ">#{header1}\n#{sequence1}\n\n> #{header2}\n#{sequence2}",
      "\n>#{header1}\n\n#{sequence1}\n\n> #{header2}\n#{sequence2}\n"
    ]

    Enum.map(raw_valid_fastas, fn(raw_fasta) ->
      [first_datum, second_datum] = FASTA.parse_string(raw_fasta)

      assert(first_datum.header == header1)
      assert(first_datum.sequence == Regex.replace(~r/\s+/, sequence1, ""))

      assert(second_datum.header == header2)
      assert(second_datum.sequence == Regex.replace(~r/\s+/, sequence2, ""))
    end)
  end

  test "parse_string returns an empty list of data from an invalid fasta string" do
    raw_invalid_fastas = [
      "> #{header1}\n> #{header2}",
      "<!DOCTYPE html>\n<html>\n</html>"
    ]

    Enum.map(raw_invalid_fastas, fn(raw_invalid_fasta) ->
      fasta_data = FASTA.parse_string(raw_invalid_fasta)

      assert(Enum.empty?(fasta_data))
    end)
  end

  test "valid_string? returns true for valid fasta strings" do
    valid_fasta_strings = [
      "> Cornus florida\nATCCTTTCTATCTG\nTTTCTGGCAT",
      "> Cornus florida\nATCCTTTCTATCTG\n\n> Acer rubrum\nTATAGCGATCAGAGTAGC"
    ]

    Enum.map(valid_fasta_strings, fn(fasta_string) ->
      assert(FASTA.valid_string?(fasta_string))
    end)
  end

  test "valid_string? returns false for invalid fasta strings" do
    invalid_fasta_strings = [
      "<!DOCTYPE html>\n<html>\n <body>\n </body>\n</html>",
      "> Cornus florida\n> Acer rubrum"
    ]

    Enum.map(invalid_fasta_strings, fn(fasta_string) ->
      refute(FASTA.valid_string?(fasta_string))
    end)
  end

  defp header1 do
    "Locus5|ncbi Polytelis swainsonii"
  end

  defp header2 do
    "Locus8|ncbi Pionus maximiliani"
  end

  defp sequence1 do
    "ATCGTAGTCTGAGTCATGA\nTGCTAGTCAGTTAGTCAGTAGC"
  end

  defp sequence2 do
    "TCGTCGTAAAAATGC"
  end
end
