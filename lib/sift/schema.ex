defmodule Sift.Schema do
  alias Sift.Schema.Field

  alias Sift.Schema.Types.{
    Boolean,
    Float,
    Integer,
    List,
    String
  }

  alias Sift.Schema.Types.Enum, as: EnumType

  @types [Boolean, EnumType, Float, Integer, List, String]

  @type_map Map.new(@types, &{&1.type_alias(), &1})

  @spec parse(any, any, nil | maybe_improper_list | map) :: {:error, any} | {:ok, any}
  def parse_with_types(params, schema, extra_types) do
    types = Map.merge(@type_map, extra_types)

    parse(params, schema, types)
  end

  def parse(params, schema, types) do
    parsed_result =
      Enum.reduce(schema, {%{}, []}, fn {key, spec}, {value_acc, error_acc} = acc ->
        result =
          params
          |> Map.get(key)
          |> parse_entry(spec, types)

        case result do
          {:ok, nil} ->
            acc

          {:ok, {field_key, field_value}} ->
            values = Map.put(value_acc, field_key, field_value)
            {values, error_acc}

          {:error, error} ->
            errors = [{key, error} | error_acc]
            {value_acc, errors}
        end
      end)

    case parsed_result do
      {data, []} ->
        {:ok, data}

      {_parsed, errors} ->
        {:error, errors}
    end
  end

  def parse_value(value, type, type_map) do
    {type_module, metadata} = get_type(type_map, type)
    apply(type_module, :parse, [type_map, value, metadata])
  end

  defp parse_entry(nil, %Field{required?: false}, _types), do: {:ok, nil}

  defp parse_entry(nil, %Field{required?: true}, _types), do: {:error, "missing required field"}

  defp parse_entry(value, %Field{type: %{} = custom_type} = spec, types) do
    case parse(value, custom_type, types) do
      {:ok, parsed_value} ->
        {:ok, {spec.key, parsed_value}}

      error ->
        error
    end
  end

  defp parse_entry(value, %Field{} = spec, types) do
    {type_module, metadata} = get_type(types, spec.type)

    case apply(type_module, :parse, [types, value, metadata]) do
      {:ok, parsed_value} ->
        {:ok, {spec.key, parsed_value}}

      error ->
        error
    end
  end

  defp get_type(types, type) do
    case type do
      {type_alias, meta} ->
        {Map.fetch!(types, type_alias), meta}

      type_alias ->
        {Map.fetch!(types, type_alias), nil}
    end
  end
end
