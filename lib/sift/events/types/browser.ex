defmodule Sift.Events.Types.Browser do
  alias Sift.Schema
  alias Sift.Schema.{Field, Type}

  @behaviour Type

  @impl Type
  def type_alias, do: :browser

  @fields %{
    user_agent: %Field{key: "$user_agent", required?: true},
    accept_language: %Field{key: "$accept_language"},
    content_language: %Field{key: "$content_language"}
  }

  @impl Type
  def parse(%{} = value, _metadata) do
    Schema.parse(value, @fields)
  end

  def parse(_value, _metadata), do: {:error, "not a map"}
end
