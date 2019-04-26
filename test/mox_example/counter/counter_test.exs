defmodule MoxExample.CounterTest do
  @moduledoc """
  Unittest the counter by starting a process per test.

  This only tests the functions, where a pid is explicitly passed. This allows
  for async tests though.
  """
  use ExUnit.Case, async: true

  setup do
    {:ok, pid} = MoxExample.Counter.start_link()
    {:ok, pid: pid}
  end

  # Test implementation
  describe "value/1" do
    test "returns 0 on start", %{pid: pid} do
      assert 0 = MoxExample.Counter.value(pid)
    end

    test "returns the number of prev. calls to increment otherwise", %{pid: pid} do
      MoxExample.Counter.increment(pid)
      MoxExample.Counter.increment(pid)
      MoxExample.Counter.increment(pid)
      assert 3 = MoxExample.Counter.value(pid)
    end

    test "can be reset", %{pid: pid} do
      MoxExample.Counter.increment(pid)
      MoxExample.Counter.reset(pid)
      assert 0 = MoxExample.Counter.value(pid)
    end
  end

  describe "increment/1" do
    test "it returns ok", %{pid: pid} do
      assert :ok = MoxExample.Counter.increment(pid)
    end
  end

  describe "reset/1" do
    test "it returns ok", %{pid: pid} do
      assert :ok = MoxExample.Counter.reset(pid)
    end
  end
end
