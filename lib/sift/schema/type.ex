defmodule Sift.Schema.Type do
  @callback type_alias() :: atom()
  @callback parse(type_map :: map(), value :: any(), metadata :: any()) ::
              {:ok, any()} | {:error, String.t()}
end
