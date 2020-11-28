defmodule Sift.Schema.Types.Integer do
  alias Sift.Schema.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :integer

  @impl Type
  def parse(_type_map, value, _metadata)
  def parse(_type_map, value, _metadata) when is_integer(value), do: {:ok, value}
  def parse(_type_map, _value, _metadata), do: {:error, "invalid integer"}
end
