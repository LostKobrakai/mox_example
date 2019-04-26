defmodule MoxExample.DomainImplTest do
  @moduledoc """
  Implementation test the domain by using the default counter.

  This only tests the functions, where no counter is explicitly passed. This must
  run with async false because it's using a global process and also that we need
  to bring up the counter to the desired state in each test manually by calling
  `increment()` on it.
  """
  use ExUnit.Case, async: false

  setup do
    MoxExample.Counter.reset()
  end

  describe "hydrate/2" do
    for i <- 0..4 do
      @i i
      test "ok for counters of #{@i}" do
        for _ <- 1..@i, do: MoxExample.Counter.increment()
        assert {:ok, _} = MoxExample.Domain.hydrate(%{x: 3, y: 4})
      end
    end

    for i <- 5..10 do
      @i i
      test "refuses to calculate for counters of #{@i}" do
        for _ <- 1..@i, do: MoxExample.Counter.increment()
        assert {:error, :limit_reached} = MoxExample.Domain.hydrate(%{x: 3, y: 4})
      end
    end
  end
end
