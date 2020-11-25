defmodule Sift.Base.Payload do
  alias Sift.Base.Schema

  def parse(params, event_name, schema) do
    with {:ok, parsed} <- Schema.apply(params, schema),
         payload <- Map.put(parsed, "$type", event_name) do
      {:ok, payload}
    end
  end
end
