defmodule Sift.Base.Types.Address do
  alias Sift.Base.{Field, Schema}
  alias Sift.Base.Types.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :address

  @fields %{
    name: %Field{key: "$name"},
    address_1: %Field{key: "$address_1"},
    address_2: %Field{key: "$address_2"},
    city: %Field{key: "$city"},
    region: %Field{key: "$region"},
    country: %Field{key: "$country", type: :country_code},
    zipcode: %Field{key: "$zipcode"},
    phone: %Field{key: "$phone"}
  }

  @impl Type
  def parse(%{} = value, _metadata) do
    Schema.apply(value, @fields)
  end

  def parse(_value, _metadata), do: {:error, "not a map"}
end
