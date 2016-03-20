defmodule ExSshd.Supervisor do
  @moduledoc false
  use Supervisor

  @doc false
  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  @doc false
  def init([]) do
    children = [
      worker(ExSshd, [])
    ]

    supervise(children, strategy: :one_for_one)
  end

end
