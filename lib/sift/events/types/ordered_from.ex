defmodule Sift.Events.Types.OrderedFrom do
  alias Sift.Schema
  alias Sift.Schema.{Field, Type}

  @behaviour Type

  @impl Type
  def type_alias, do: :ordered_from

  @fields %{
    store_id: %Field{key: "$store_id"},
    store_address: %Field{key: "store_address", type: :address}
  }

  @impl Type
  def parse(type_map, %{} = value, _metadata) do
    Schema.parse(value, @fields, type_map)
  end

  def parse(_type_map, _value, _metadata), do: {:error, "not a map"}
end
