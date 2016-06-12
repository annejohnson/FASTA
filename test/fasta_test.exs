defmodule FASTATest do
  use ExUnit.Case
  doctest FASTA

  test "valid_string? returns true for valid fasta strings" do
    Enum.map(valid_fasta_strings, fn(fasta_string) ->
      assert(FASTA.valid_string?(fasta_string))
    end)
  end

  test "valid_string? returns false for invalid fasta strings" do
    Enum.map(invalid_fasta_strings, fn(fasta_string) ->
      refute(FASTA.valid_string?(fasta_string))
    end)
  end

  defp valid_fasta_strings do
    [
      "> Cornus florida\nATCCTTTCTATCTG\nTTTCTGGCAT",
      "> Cornus florida\nATCCTTTCTATCTG\n\n> Acer rubrum\nTATAGCGATCAGAGTAGC"
    ]
  end

  defp invalid_fasta_strings do
    [
      "<!DOCTYPE html>\n<html>\n <body>\n </body>\n</html>",
      "> Cornus florida\n> Acer rubrum"
    ]
  end
end
