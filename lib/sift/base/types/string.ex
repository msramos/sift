defmodule Sift.Base.Types.String do
  alias Sift.Base.Types.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :string

  @impl Type
  def parse(value, _metadata)
  def parse(value, _metadata) when is_binary(value), do: {:ok, value}
  def parse(_value, _metadata), do: {:error, "invalid string"}
end
