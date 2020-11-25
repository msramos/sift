defmodule Sift.Base.Types.Float do
  alias Sift.Base.Types.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :float

  @impl Type
  def parse(value, _metadata) when is_float(value), do: {:ok, value}
  def parse(_value, _metadata), do: {:error, "invalid float"}
end
