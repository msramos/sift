defmodule Sift.Events.Types.CreditPoint do
  alias Sift.Schema
  alias Sift.Schema.{Field, Type}

  @behaviour Type

  @impl Type
  def type_alias, do: :credit_point

  @fields %{
    amount: %Field{key: "$amount", type: :integer, required?: true},
    credit_point_type: %Field{key: "$credit_point_type", required?: true}
  }

  @impl Type
  def parse(type_map, %{} = value, _metadata) do
    Schema.parse(value, @fields, type_map)
  end

  def parse(_type_map, _value, _metadata), do: {:error, "not a map"}
end
