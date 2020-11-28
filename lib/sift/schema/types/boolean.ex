defmodule Sift.Schema.Types.Boolean do
  alias Sift.Schema.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :boolean

  @impl Type
  def parse(_type_map, value, _metadata) when is_boolean(value), do: {:ok, value}
  def parse(_type_map, _value, _metadata), do: {:error, "invalid boolean"}
end
