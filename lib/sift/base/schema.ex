defmodule Sift.Base.Schema do
  alias Sift.Base.{Field, Types}

  def apply(params, schema) do
    parsed_result =
      Enum.reduce(schema, {%{}, []}, fn {key, spec}, {value_acc, error_acc} = acc ->
        result =
          params
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

  defp parse_entry(nil, %Field{required?: false}), do: {:ok, nil}

  defp parse_entry(nil, %Field{required?: true}), do: {:error, "missing required field"}

  defp parse_entry(value, %Field{type: %{} = custom_type} = spec) do
    case __MODULE__.apply(value, custom_type) do
      {:ok, parsed_value} ->
        {:ok, {spec.key, parsed_value}}

      error ->
        error
    end
  end

  defp parse_entry(value, %Field{} = spec) do
    case Types.parse(value, spec.type) do
      {:ok, parsed_value} ->
        {:ok, {spec.key, parsed_value}}

      error ->
        error
    end
  end
end
