defmodule Sift.Schema.Types.List do
  alias Sift.Schema
  alias Sift.Schema.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :list

  @impl Type
  def parse(values, item_type)

  def parse(values, item_type) when is_list(values) do
    result =
      Enum.reduce_while(values, [], fn v, acc ->
        case Schema.parse_value(v, item_type) do
          {:ok, value} ->
            {:cont, [value | acc]}

          {:error, error} ->
            {:halt, {:error, error}}
        end
      end)

    case result do
      {:error, error} -> {:error, error}
      parsed -> {:ok, Enum.reverse(parsed)}
    end
  end

  def parse(_value, _opts), do: {:error, "not a list"}
end
