defmodule Sift.Base.Types.Boolean do
  alias Sift.Base.Types.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :boolean

  @impl Type
  def parse(value, _metadata) when is_boolean(value), do: {:ok, value}
  def parse(_value, _metadata), do: {:error, "invalid boolean"}
end
