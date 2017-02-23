defmodule Moneta.Mixfile do
  use Mix.Project

  def project do
    [app: :moneta,
     version: "0.0.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [applications: [:logger, :kitto, :hackney]]
  end

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:kitto, "~> 0.5.1"},
     {:tesla, "~> 0.6.0"},
     {:poison, ">= 1.0.0"}
    ] # for JSON middleware]

  end
end
