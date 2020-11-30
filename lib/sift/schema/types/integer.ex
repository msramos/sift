defmodule Sift.Schema.Types.Integer do
  alias Sift.Schema.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :integer

  @impl Type
  def parse(value, _metadata)
  def parse(value, _metadata) when is_integer(value), do: {:ok, value}
  def parse(_value, _metadata), do: {:error, "invalid integer"}
end
