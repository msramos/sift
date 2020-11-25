defmodule Sift.Base.Types.Enum do
  alias Sift.Base.Types.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :enum

  @impl Type
  def parse(value, allowed_values)

  def parse(value, allowed_values) when is_atom(value) do
    case value in allowed_values do
      true -> {:ok, "$#{Atom.to_string(value)}"}
      false -> {:error, "invalid value '#{value}'"}
    end
  end

  def parse(value, allowed_values) when is_binary(value) do
    case value in allowed_values do
      true -> {:ok, value}
      false -> {:error, "invalid value '#{value}'"}
    end
  end

  def parse(_value, _opts), do: {:error, "invalid value"}
end
