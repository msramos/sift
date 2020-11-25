defmodule Sift.Base.Types.Item do
  alias Sift.Base.{Field, Schema}
  alias Sift.Base.Types.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :item

  @fields %{
    item_id: %Field{key: "$item_id"},
    product_title: %Field{key: "$product_title"},
    price: %Field{key: "$price", type: :integer},
    currency_code: %Field{key: "$currency_code", type: :currency_code},
    quantity: %Field{key: "$quantity", type: :integer},
    upc: %Field{key: "$upc"},
    sku: %Field{key: "$sku"},
    isbn: %Field{key: "$isbn"},
    brand: %Field{key: "$brand"},
    manufacturer: %Field{key: "$manufacturer"},
    category: %Field{key: "$category"},
    tags: %Field{key: "$tags", type: {:list, :string}},
    color: %Field{key: "$color"},
    size: %Field{key: "$size"}
  }

  @impl Type
  def parse(%{} = value, _metadata) do
    Schema.apply(value, @fields)
  end

  def parse(_value, _metadata), do: {:error, "not a map"}
end
