defmodule FASTA do
  @moduledoc false

  def valid_string?(str) do
    str
    |> FASTA.Parser.parse
    |> Enum.any?
  end
end
