defmodule Sift.Decisions do
  alias Sift.HTTP.Request
  alias Sift.Schema
  alias Sift.Schema.Field

  @apply_decisions_fields %{
    decision_id: %Field{key: "id", required?: true},
    source: %Field{
      key: "source",
      required?: true,
      type: {:enum, ["MANUAL_REVIEW", "AUTOMATED_RULE", "CHARGEBACK"]}
    },
    analyst: %Field{key: "analyst"},
    time: %Field{key: "time", type: :integer},
    description: %Field{key: "description"}
  }

  def apply_user_decision(account_id, user_id, params) do
    url = "https://api.sift.com/v3/accounts/#{account_id}/users/#{user_id}/decisions"
    apply_decision(url, params)
  end

  def apply_order_decision(account_id, user_id, order_id, params) do
    url =
      "https://api.sift.com/v3/accounts/#{account_id}/users/#{user_id}/orders/#{order_id}/decisions"

    apply_decision(url, params)
  end

  def apply_session_decision(account_id, user_id, session_id, params) do
    url =
      "https://api.sift.com/v3/accounts/#{account_id}/users/#{user_id}/sessions/#{session_id}/decisions"

    apply_decision(url, params)
  end

  def apply_content_decision(account_id, user_id, content_id, params) do
    url =
      "https://api.sift.com/v3/accounts/#{account_id}/users/#{user_id}/content/#{content_id}/decisions"

    apply_decision(url, params)
  end

  def apply_content_decision(%{}), do: {:error, "missing account_id, user_id and/or content_id"}

  defp apply_decision(url, params) do
    with {:ok, payload} <- Schema.parse(params, @apply_decisions_fields) do
      {:ok,
       %Request{
         method: :post,
         url: url,
         body: payload
       }}
    end
  end

  def user_decision_status(account_id, user_id) do
    url = "https://api.sift.com/v3/accounts/#{account_id}/users/#{user_id}/decisions"
    {:ok, %Request{url: url, method: :get}}
  end

  def order_decision_status(account_id, order_id) do
    url = "https://api.sift.com/v3/accounts/#{account_id}/orders/#{order_id}/decisions"
    {:ok, %Request{url: url, method: :get}}
  end

  def session_decision_status(account_id, user_id, session_id) do
    url =
      "https://api.sift.com/v3/accounts/#{account_id}/users/#{user_id}/sessions/#{session_id}/decisions"

    {:ok, %Request{url: url, method: :get}}
  end

  def content_decision_status(account_id, user_id, content_id) do
    url =
      "https://api.sift.com/v3/accounts/#{account_id}/users/#{user_id}/content/#{content_id}/decisions"

    {:ok, %Request{url: url, method: :get}}
  end

  @get_decisions_fields %{
    entity_type: %Field{
      key: "entity_type",
      type: {:enum, ["USER", "ORDER", "SESSION", "CONTENT"]}
    },
    abuse_types: %Field{
      key: "abuse_types",
      type:
        {:list,
         {:enum,
          [
            "LEGACY",
            "PAYMENT_ABUSE",
            "ACCOUNT_ABUSE",
            "CONTENT_ABUSE",
            "PROMO_ABUSE",
            "ACCOUNT_TAKEOVER"
          ]}}
    },
    limit: %Field{key: "limit", type: :integer},
    from: %Field{key: "from", type: :integer}
  }

  def get_decisions(account_id, params) do
    with {:ok, fields} <- Schema.parse(params, @get_decisions_fields) do
      fields =
        case fields["abuse_types"] do
          nil -> fields
          value -> Map.put(fields, "abuse_types", Enum.join(value, ","))
        end

      url = "https://api.sift.com/v3/accounts/#{account_id}/decisions?#{URI.encode_query(fields)}"
      {:ok, %Request{url: url, method: :get}}
    end
  end
end
