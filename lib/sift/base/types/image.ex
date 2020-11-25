defmodule Sift.Base.Types.Image do
  alias Sift.Base.{Field, Schema}
  alias Sift.Base.Types.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :image

  @fields %{
    md5_hash: %Field{key: "$md5_hash"},
    link: %Field{key: "$link"},
    description: %Field{key: "$description"}
  }

  @impl Type
  def parse(%{} = value, _metadata) do
    Schema.apply(value, @fields)
  end

  def parse(_value, _metadata), do: {:error, "not a map"}
end
