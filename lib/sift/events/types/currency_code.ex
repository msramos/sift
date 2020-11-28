defmodule Sift.Events.Types.CurrencyCode do
  alias Sift.Schema.Type

  @behaviour Type

  @external_resource Path.join([__DIR__, "currency_code.csv"])

  @currency_codes Path.join([__DIR__, "currency_code.csv"])
                  |> File.read!()
                  |> String.split("\n")
                  |> Enum.map(fn code -> code end)

  @impl Type
  def type_alias, do: :currency_code

  @impl Type
  def parse(_type_map, <<_::utf8, _::utf8, _::utf8>> = code, _metadata) when code in @currency_codes do
    {:ok, code}
  end

  def parse(_type_map, code, _metadata), do: {:error, "invalid currency code #{inspect(code)}"}
end
