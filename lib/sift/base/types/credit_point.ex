defmodule Sift.Base.Types.CreditPoint do
  alias Sift.Base.{Field, Schema}
  alias Sift.Base.Types.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :credit_point

  @fields %{
    amount: %Field{key: "$amount", type: :integer, required?: true},
    credit_point_type: %Field{key: "$credit_point_type", required?: true}
  }

  @impl Type
  def parse(%{} = value, _metadata) do
    Schema.apply(value, @fields)
  end

  def parse(_value, _metadata), do: {:error, "not a map"}
end
