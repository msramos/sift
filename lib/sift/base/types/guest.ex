defmodule Sift.Base.Types.Guest do
  alias Sift.Base.{Field, Schema}
  alias Sift.Base.Types.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :guest

  @fields %{
    name: %Field{key: "$name"},
    email: %Field{key: "$email"},
    phone: %Field{key: "$phone"},
    loyalty_program: %Field{key: "$loyalty_program"},
    loyalty_program_id: %Field{key: "$loyalty_program_id"},
    birth_date: %Field{key: "$birth_date"}
  }

  @impl Type
  def parse(%{} = value, _metadata) do
    Schema.apply(value, @fields)
  end

  def parse(_value, _metadata), do: {:error, "not a map"}
end
