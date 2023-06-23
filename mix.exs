defmodule PagerLiveView.MixProject do
  use Mix.Project

  def project do
    [
      app: :pager_liveview,
      name: "Pager LiveView",
      description: "LiveView Template Helpers to use in conjunction with the Pager library and TailwindCSS",
      source_url: "https://github.com/or-equals/pager_liveview",
      version: "0.4.0",
      elixir: ">= 1.11.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix_live_view, ">= 0.16.0"},
      {:phoenix_html, "~> 3.0"},
      {:jason, "~> 1.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Joshua Plicque"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/or-equals/pager"},
    ]
  end
end
