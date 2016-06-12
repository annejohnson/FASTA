defmodule FASTA.Mixfile do
  use Mix.Project

  def project do
    [app: :fasta,
     version: "0.0.1",
     elixir: "~> 1.2",
     description: description,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     package: package]
  end

  def application do
    [applications: [:logger]]
  end

  defp description do
    "FASTA is a tool for parsing FASTA-formatted strings in Elixir."
  end

  defp package do
    [licenses: ["MIT"],
     maintainers: ["annecodes@gmail.com"],
     links: %{"GitHub" => "https://github.com/annejohnson/FASTA"}]
  end

  defp deps do
    [{:parallel, "~> 0.0.3"},
     {:earmark, "~> 0.1", only: :dev},
     {:ex_doc, "~> 0.11", only: :dev}]
  end
end
