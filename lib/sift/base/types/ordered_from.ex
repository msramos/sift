defmodule Sift.Base.Types.OrderedFrom do
  alias Sift.Base.{Field, Schema}
  alias Sift.Base.Types.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :ordered_from

  @fields %{
    store_id: %Field{key: "$store_id"},
    store_address: %Field{key: "store_address", type: :address}
  }

  @impl Type
  def parse(%{} = value, _metadata) do
    Schema.apply(value, @fields)
  end

  def parse(_value, _metadata), do: {:error, "not a map"}
end
