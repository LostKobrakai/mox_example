defmodule MoxExample.Domain do
  @moduledoc """
  The app does hydrate a map with more information.

  The domain requires the hydration to not
  work if the counter was already incremented to 5 or higher.
  """

  @doc """
  By default this is supposed to use a globally started counter, which is
  how the app would operate in production.
  """
  def hydrate(%{x: x, y: y} = map, counter \\ MoxExample.Counter) do
    if counter.value() < 5 do
      dist = :math.sqrt(:math.pow(x, 2) + :math.pow(y, 2))
      {:ok, Map.put(map, :from_origin, dist)}
    else
      {:error, :limit_reached}
    end
  end
end
