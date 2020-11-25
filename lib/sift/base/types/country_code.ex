defmodule Sift.Base.Types.CountryCode do
  alias Sift.Base.Types.Type

  @behaviour Type

  @external_resource Path.join([__DIR__, "country_code.csv"])

  @country_codes Path.join([__DIR__, "country_code.csv"])
                 |> File.read!()
                 |> String.split("\n")

  @impl Type
  def type_alias, do: :country_code

  @impl Type
  def parse(<<_::utf8, _::utf8>> = code, _metadata) when code in @country_codes do
    {:ok, code}
  end

  def parse(code, _metadata), do: {:error, "invalid country code #{inspect(code)}"}
end
