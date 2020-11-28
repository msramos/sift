defmodule Sift.Events.Types.Discount do
  alias Sift.Schema
  alias Sift.Schema.{Field, Type}

  @behaviour Type

  @impl Type
  def type_alias, do: :discount

  @fields %{
    percentage_off: %Field{key: "$percentage_off", type: :float},
    amount: %Field{key: "$amount", type: :integer},
    currency_code: %Field{key: "$currency_code", type: :currency_code},
    minimum_purchase_amount: %Field{key: "$minimum_purchase_amount", type: :integer}
  }

  @impl Type
  def parse(type_map, %{} = value, _metadata) do
    Schema.parse(value, @fields, type_map)
  end

  def parse(_type_map, _value, _metadata), do: {:error, "not a map"}
end
