defmodule Sift.Events.Types.Segment do
  alias Sift.Events.Types.Address
  alias Sift.Schema
  alias Sift.Schema.{Field, Type}

  @behaviour Type

  @iata_codes_csv Path.join([__DIR__, "segment.iata.csv"])

  @external_resource @iata_codes_csv

  @iata_codes @iata_codes_csv
              |> File.read!()
              |> String.split("\n")

  @fields %{
    departure_address: %Field{key: "$departure_address", type: Address},
    arrival_address: %Field{key: "$arrival_address", type: Address},
    start_time: %Field{key: "$start_time", type: :integer},
    end_time: %Field{key: "$end_time", type: :integer},
    vessel_number: %Field{key: "$vessel_number"},
    departure_airport_code: %Field{key: "$departure_airport_code", type: {:enum, @iata_codes}},
    arrival_airport_code: %Field{key: "$arrival_airport_code", type: {:enum, @iata_codes}},
    fare_class: %Field{key: "$fare_class"}
  }

  @impl Type
  def type_alias, do: :segment

  @impl Type
  def parse(%{} = value, _metadata) do
    Schema.parse(value, @fields)
  end

  def parse(_value, _metadata), do: {:error, "not a map"}
end
