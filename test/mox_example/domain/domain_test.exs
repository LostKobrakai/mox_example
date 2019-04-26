defmodule MoxExample.DomainTest do
  @moduledoc """
  Unittest the domain by mocking the counter.

  This only tests the functions, where a counter is explicitly passed. This allows
  for async tests and to mock to counter to let it directly return the values
  each certain test needs without first needing to increment the counter manually to
  a certain state.
  """
  use ExUnit.Case, async: true
  import Mox

  setup :verify_on_exit!

  describe "hydrate/2" do
    @doc """
    This function even stubs the counters function, as we simply want the hydration to
    not fail, but otherwise don't care about it running for the assertion the
    test is trying to make.
    """
    test "calculates the correct distance" do
      stub(MoxExample.CounterMock, :value, fn -> 0 end)

      examples = [
        %{x: 2, y: 3, from_origin: 3.605},
        %{x: 3, y: 4, from_origin: 5.0}
      ]

      for %{from_origin: expected} = example <- examples do
        map = Map.take(example, [:x, :y])

        assert {:ok, %{from_origin: result}} =
                 MoxExample.Domain.hydrate(map, MoxExample.CounterMock)

        assert_in_delta result, expected, 0.01
      end
    end

    test "calculates the distance for a counter below 5" do
      for i <- 0..4 do
        expect(MoxExample.CounterMock, :value, fn -> i end)
        map = %{x: 3, y: 4}
        assert {:ok, %{from_origin: 5.0}} = MoxExample.Domain.hydrate(map, MoxExample.CounterMock)
      end
    end

    test "refuses to calculate for counters greater than or equal to 5" do
      for i <- 5..10 do
        expect(MoxExample.CounterMock, :value, fn -> i end)
        map = %{x: 3, y: 4}
        assert {:error, :limit_reached} = MoxExample.Domain.hydrate(map, MoxExample.CounterMock)
      end
    end
  end
end
