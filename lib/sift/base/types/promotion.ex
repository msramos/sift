defmodule Sift.Base.Types.Promotion do
  alias Sift.Base.{Field, Schema}
  alias Sift.Base.Types.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :promotion

  @fields %{
    promotion_id: %Field{key: "$promotion_id"},
    status: %Field{key: "$status", type: {:enum, [:success, :failure]}},
    failure_reason: %Field{
      key: "$failure_reason",
      type: {:enum, [:already_used, :invalid_code, :not_applicable, :expired]}
    },
    description: %Field{key: "$description"},
    referrer_user_id: %Field{key: "$referrer_user_id"},
    discount: %Field{key: "$discount", type: :discount},
    credit_point: %Field{key: "$credit_point", type: :credit_point}
  }

  @impl Type
  def parse(%{} = value, _metadata) do
    Schema.apply(value, @fields)
  end

  def parse(_value, _metadata), do: {:error, "not a map"}
end
