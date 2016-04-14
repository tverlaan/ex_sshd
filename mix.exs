defmodule ExSshd.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_sshd,
     version: "0.0.2",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description,
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      applications: [:ssh],
      mod: {ExSshd.Application, []}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    []
  end

  defp description do
    """
    Simple Elixir SSH worker that provides an Elixir shell over SSH into your application.
    """
  end

  defp package do
    [# These are the default files included in the package
      files: ["lib", "mix.exs", "README.md", "LICENSE.md", "make_host_key", "make_keys"],
      maintainers: ["Timmo Verlaan"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/tverlaan/ex_sshd"}
    ]
  end
end
