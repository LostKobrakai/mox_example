defmodule MoxExample.CounterImplTest do
  @moduledoc """
  Implementation test the counter by using the globally started process.

  This only tests the functions, where no pid is explicitly passed. This must
  run with async false because it's using a global process.
  """
  use ExUnit.Case, async: false

  setup do
    MoxExample.Counter.reset()
  end

  # Test implementation
  describe "value/1" do
    test "returns 0 on start" do
      assert 0 = MoxExample.Counter.value()
    end

    test "returns the number of prev. calls to increment otherwise" do
      MoxExample.Counter.increment()
      MoxExample.Counter.increment()
      MoxExample.Counter.increment()
      assert 3 = MoxExample.Counter.value()
    end
  end

  describe "increment/1" do
    test "it returns ok" do
      assert :ok = MoxExample.Counter.increment()
    end
  end
end
