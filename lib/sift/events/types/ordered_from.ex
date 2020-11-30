defmodule Sift.Events.Types.OrderedFrom do
  alias Sift.Events.Types.Address
  alias Sift.Schema
  alias Sift.Schema.{Field, Type}

  @behaviour Type

  @impl Type
  def type_alias, do: :ordered_from

  @fields %{
    store_id: %Field{key: "$store_id"},
    store_address: %Field{key: "store_address", type: Address}
  }

  @impl Type
  def parse(%{} = value, _metadata) do
    Schema.parse(value, @fields)
  end

  def parse(_value, _metadata), do: {:error, "not a map"}
end
