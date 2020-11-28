defmodule Sift.Schema.Types.Enum do
  alias Sift.Schema.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :enum

  @impl Type
  def parse(_type_map, value, allowed_values)

  def parse(_type_map, value, allowed_values) when is_atom(value) do
    case value in allowed_values do
      true -> {:ok, "$#{Atom.to_string(value)}"}
      false -> {:error, "invalid value '#{value}'"}
    end
  end

  def parse(_type_map, value, allowed_values) when is_binary(value) do
    case value in allowed_values do
      true -> {:ok, value}
      false -> {:error, "invalid value '#{value}'"}
    end
  end

  def parse(_type_map, _value, _opts), do: {:error, "invalid value"}
end
