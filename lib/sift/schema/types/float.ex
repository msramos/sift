defmodule Sift.Schema.Types.Float do
  alias Sift.Schema.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :float

  @impl Type
  def parse(_type_map, value, _metadata) when is_float(value), do: {:ok, value}
  def parse(_type_map, _value, _metadata), do: {:error, "invalid float"}
end
