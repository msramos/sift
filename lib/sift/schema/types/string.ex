defmodule Sift.Schema.Types.String do
  alias Sift.Schema.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :string

  @impl Type
  def parse(value, _metadata) when is_binary(value), do: {:ok, value}
  def parse(_value, _metadata), do: {:error, "invalid string"}
end
