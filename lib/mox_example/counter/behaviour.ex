defmodule MoxExample.Counter.Behaviour do
  @moduledoc """
  The behaviour for the counter.
  """
  @callback value() :: number()
  @callback increment() :: :ok
end
