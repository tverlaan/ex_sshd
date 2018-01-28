defmodule ExSshd do
  @moduledoc """
  An Elixir SSH worker. It provides a SSH interface to your Elixir application.
  """
  use GenServer

  @sshd_port 10022
  @app_name :ex_sshd

  defstruct [:port, :credentials, :pid, :priv_dir]

  @doc false
  def start_link do
    GenServer.start_link __MODULE__, [], name: __MODULE__
  end

  @doc false
  def init([]) do
    # configuration defaults
    port        = Application.get_env :ex_sshd, :port, @sshd_port
    master_app  = Application.get_env :ex_sshd, :app, @app_name

    # set the priv dir containing the keys
    app_dir     = Application.app_dir master_app
    priv_dir    = Path.join([app_dir, "priv", "ex_sshd"])
                  |> String.to_charlist()

    # transform credentials from strings to char lists
    credentials = Application.get_env(:ex_sshd, :credentials, [])
                  |> Enum.map(fn({u,p}) -> {String.to_charlist(u), String.to_charlist(p)} end)

    GenServer.cast self(), :start

    {:ok, %__MODULE__{port: port, priv_dir: priv_dir, credentials: credentials}}
  end

  @doc false
  def handle_cast(:start, %__MODULE__{port: port, priv_dir: priv_dir, credentials: credentials} = state) do
    # start ssh
    {:ok, pid} = :ssh.daemon port,  shell: {IEx, :start, []},
                                    system_dir: priv_dir,
                                    user_dir: priv_dir,
                                    user_passwords: credentials

    # link to ssh pid
    Process.link pid

    {:noreply, %__MODULE__{ state | pid: pid }, :hibernate}
  end

end
