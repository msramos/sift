defmodule Sift.Schema.Types.Enum do
  alias Sift.Schema.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :enum

  @impl Type
  def parse(value, allowed_values)

  def parse(value, {prefix, allowed_values}) do
    do_parse(value, allowed_values, prefix)
  end

  def parse(value, allowed_values) when is_atom(value) do
    do_parse(value, allowed_values, "$")
  end

  def parse(value, allowed_values) when is_binary(value) do
    do_parse(value, allowed_values)
  end

  def parse(_value, _opts), do: {:error, "invalid value"}

  def do_parse(value, allowed_values, prefix \\ "") do
    case value in allowed_values do
      true ->
        value = if is_atom(value), do: Atom.to_string(value), else: value
        {:ok, prefix <> value}

      false ->
        {:error, "invalid value '#{value}'"}
    end
  end
end
