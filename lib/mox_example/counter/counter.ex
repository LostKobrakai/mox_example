defmodule MoxExample.Counter do
  @moduledoc """
  A simple counter.

  This is a stateful process, so it's a simple but worthwhile example for something
  to be mocked.
  """
  use Agent

  @behaviour MoxExample.Counter.Behaviour

  def start_link(opts \\ []) do
    Agent.start_link(fn -> 0 end, Keyword.take(opts, [:name]))
  end

  def value(pid \\ __MODULE__) do
    Agent.get(pid, & &1)
  end

  def increment(pid \\ __MODULE__) do
    Agent.update(pid, &(&1 + 1))
  end

  def reset(pid \\ __MODULE__) do
    Agent.update(pid, fn _ -> 0 end)
  end
end
