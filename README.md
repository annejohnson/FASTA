# FASTA [![Hex.pm](https://img.shields.io/hexpm/v/fasta.svg?style=flat-square)](https://hex.pm/packages/fasta)

This is a tool for parsing [FASTA](https://en.wikipedia.org/wiki/FASTA_format) strings into structured sequence data.

## Installation

Add `FASTA` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:fasta, "~> 0.0.1"}]
end
```

## Usage

```elixir
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
```

[View full documentation here](https://hexdocs.pm/fasta/api-reference.html).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/annejohnson/FASTA. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
