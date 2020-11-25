defmodule Sift.Base.Types.PaymentMethod do
  alias Sift.Base.{Field, Schema}
  alias Sift.Base.Types.Type

  @behaviour Type

  @payment_gateways_csv Path.join([__DIR__, "payment_method.gateways.csv"])
  @payment_types_csv Path.join([__DIR__, "payment_method.types.csv"])

  @external_resource @payment_gateways_csv
  @external_resource @payment_types_csv

  @payment_gateways @payment_gateways_csv
                    |> File.read!()
                    |> String.split("\n")
                    |> Enum.map(&String.to_atom/1)

  @payment_types @payment_types_csv
                 |> File.read!()
                 |> String.split("\n")
                 |> Enum.map(&String.to_atom/1)

  @fields %{
    payment_type: %Field{key: "$payment_type", type: {:enum, @payment_types}},
    payment_gateway: %Field{key: "$payment_gateway", type: {:enum, @payment_gateways}},
    card_bin: %Field{key: "$card_bin"},
    card_last4: %Field{key: "$card_last4"},
    avs_result_code: %Field{key: "$avs_result_code"},
    cvv_result_code: %Field{key: "$cvv_result_code"},
    verification_status: %Field{
      key: "$verification_status",
      type: {:enum, [:success, :failure, :pending]}
    },
    routing_number: %Field{key: "$routing_number"},
    decline_reason_code: %Field{key: "$decline_reason_code"},
    paypal_payer_id: %Field{key: "$paypal_payer_id"},
    paypal_payer_email: %Field{key: "$paypal_payer_email"},
    paypal_payer_status: %Field{key: "$paypal_payer_status"},
    paypal_address_status: %Field{key: "$paypal_address_status"},
    paypal_protection_eligibility: %Field{key: "$paypal_protection_eligibility"},
    paypal_payment_status: %Field{key: "$paypal_payment_status"},
    stripe_cvc_check: %Field{key: "$stripe_cvc_check"},
    stripe_address_line1_check: %Field{key: "$stripe_address_line1_check"},
    stripe_address_line2_check: %Field{key: "$stripe_address_line2_check"},
    stripe_address_zip_check: %Field{key: "$stripe_address_zip_check"},
    stripe_funding: %Field{key: "$stripe_funding"},
    stripe_brand: %Field{key: "$stripe_brand"}
  }

  @impl Type
  def type_alias, do: :payment_method

  @impl Type
  def parse(%{} = value, _metadata) do
    Schema.apply(value, @fields)
  end

  def parse(_value, _metadata), do: {:error, "not a map"}
end
