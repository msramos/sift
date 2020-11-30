defmodule Sift.Schema do
  alias Sift.Schema.Field
  alias Sift.Schema.Types.Boolean, as: BooleanType
  alias Sift.Schema.Types.Enum, as: EnumType
  alias Sift.Schema.Types.Float, as: FloatType
  alias Sift.Schema.Types.Integer, as: IntegerType
  alias Sift.Schema.Types.List, as: ListType
  alias Sift.Schema.Types.String, as: StringType

  @basic_types_list [BooleanType, EnumType, FloatType, IntegerType, ListType, StringType]

  @basic_types Map.new(@basic_types_list, &{&1.type_alias(), &1})

  @basic_types_aliases Enum.map(@basic_types_list, & &1.type_alias())

  def parse(input, field_specs) do
    parsed_result =
      Enum.reduce(field_specs, {%{}, []}, fn {key, spec}, {value_acc, error_acc} = acc ->
        result =
          input
          |> Map.get(key)
          |> parse_entry(spec)

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

  def parse_value(input, type) do
    {type_module, metadata} = type_module_and_metadata(type)
    apply(type_module, :parse, [input, metadata])
  end

  defp parse_entry(nil, %Field{required?: false}), do: {:ok, nil}

  defp parse_entry(nil, %Field{required?: true}), do: {:error, "missing required field"}

  defp parse_entry(input, %Field{type: %{} = custom_complex_type} = spec) do
    case parse(input, custom_complex_type) do
      {:ok, parsed_value} ->
        {:ok, {spec.key, parsed_value}}

      error ->
        error
    end
  end

  defp parse_entry(input, %Field{} = spec) do
    {type_module, metadata} = type_module_and_metadata(spec.type)

    case apply(type_module, :parse, [input, metadata]) do
      {:ok, parsed_value} ->
        {:ok, {spec.key, parsed_value}}

      error ->
        error
    end
  end

  defp type_module_and_metadata({type_alias, metadata}) when type_alias in @basic_types_aliases do
    {Map.fetch!(@basic_types, type_alias), metadata}
  end

  defp type_module_and_metadata(type_alias) when type_alias in @basic_types_aliases do
    {Map.fetch!(@basic_types, type_alias), nil}
  end

  defp type_module_and_metadata({type_module, metadata}) when is_atom(type_module) do
    {type_module, metadata}
  end

  defp type_module_and_metadata(type_module) when is_atom(type_module) do
    {type_module, nil}
  end
end
