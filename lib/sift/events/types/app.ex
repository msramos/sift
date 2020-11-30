defmodule Sift.Events.Types.App do
  alias Sift.Schema
  alias Sift.Schema.{Field, Type}

  @behaviour Type

  @impl Type
  def type_alias, do: :app

  @fields %{
    os: %Field{key: "$os"},
    os_version: %Field{key: "$os_version"},
    device_manufacturer: %Field{key: "$device_manufacturer"},
    device_model: %Field{key: "$device_model"},
    device_unique_id: %Field{key: "$device_unique_id"},
    app_name: %Field{key: "$app_name"},
    app_version: %Field{key: "$app_version"},
    client_language: %Field{key: "$client_language"}
  }

  @impl Type
  def parse(%{} = value, _metadata) do
    Schema.parse(value, @fields)
  end

  def parse(_value, _metadata), do: {:error, "not a map"}
end
