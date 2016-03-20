defmodule ExSshd.Application do
  @moduledoc false
  use Application

  @doc false
  def start(_,_) do
    ExSshd.Supervisor.start_link()
  end

end
