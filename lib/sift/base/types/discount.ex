defmodule Sift.Base.Types.Discount do
  alias Sift.Base.{Field, Schema}
  alias Sift.Base.Types.Type

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
  def parse(%{} = value, _metadata) do
    Schema.apply(value, @fields)
  end

  def parse(_value, _metadata), do: {:error, "not a map"}
end
