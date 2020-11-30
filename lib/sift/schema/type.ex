defmodule Sift.Schema.Type do
  @callback type_alias() :: atom()
  @callback parse(value :: any(), metadata :: any()) :: {:ok, any()} | {:error, String.t()}
end
