defmodule Sift.Schema.Types.Boolean do
  alias Sift.Schema.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :boolean

  @impl Type
  def parse(value, _metadata) when is_boolean(value), do: {:ok, value}
  def parse(_value, _metadata), do: {:error, "invalid boolean"}
end
