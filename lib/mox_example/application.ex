defmodule MoxExample.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the global counter for usage in teh domain
      {MoxExample.Counter, [name: MoxExample.Counter]}
    ]

    opts = [strategy: :one_for_one, name: MoxExample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
