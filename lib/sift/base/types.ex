defmodule Sift.Base.Types do
  alias Sift.Base.Types.{
    Address,
    App,
    Booking,
    Browser,
    CountryCode,
    CurrencyCode,
    CreditPoint,
    Discount,
    Enum,
    Float,
    Guest,
    Image,
    Integer,
    Item,
    List,
    OrderedFrom,
    PaymentMethod,
    Promotion,
    Segment,
    String
  }

  @types [
    Address,
    App,
    Booking,
    Browser,
    CountryCode,
    CurrencyCode,
    CreditPoint,
    Discount,
    Enum,
    Float,
    Guest,
    Image,
    Integer,
    Item,
    List,
    OrderedFrom,
    PaymentMethod,
    Promotion,
    Segment,
    String
  ]

  @aliases Map.new(@types, &{&1.type_alias(), &1})

  @doc """
  Parses a value with the given type
  """
  def parse(value, type)

  def parse(value, {type, metadata}) do
    type_module = Map.fetch!(@aliases, type)
    type_module.parse(value, metadata)
  end

  def parse(value, type) do
    type_module = Map.fetch!(@aliases, type)
    type_module.parse(value, nil)
  end
end
