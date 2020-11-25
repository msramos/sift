defmodule Sift.Base.Types.Booking do
  alias Sift.Base.{Field, Schema}
  alias Sift.Base.Types.Type

  @behaviour Type

  @impl Type
  def type_alias, do: :booking

  @booking_types [
    :event_ticket,
    :accommodation,
    :flight,
    :bus,
    :rideshare,
    :vehicle,
    :cruise,
    :other
  ]

  @fields %{
    booking_type: %Field{key: "$booking_type", required?: true, type: {:enum, @booking_types}},
    title: %Field{key: "$title"},
    start_time: %Field{key: "$start_time", type: :integer},
    end_time: %Field{key: "$start_time", type: :integer},
    price: %Field{key: "$price"},
    currency_code: %Field{key: "$currency_code", type: :currency_code},
    quantity: %Field{key: "$quantity", type: :integer},
    guests: %Field{key: "$guests", type: {:list, :guest}},
    segments: %Field{key: "$segments", type: {:list, :segment}},
    tags: %Field{key: "$tags", type: {:list, :string}},
    room_type: %Field{key: "$room_type"},
    event_id: %Field{key: "$event_id"},
    venue_id: %Field{key: "$venue_id"},
    location: %Field{key: "$location", type: :address},
    category: %Field{key: "$category"}
  }

  @impl Type
  def parse(%{} = value, _metadata) do
    Schema.apply(value, @fields)
  end

  def parse(_value, _metadata), do: {:error, "not a map"}
end
