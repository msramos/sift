defmodule Sift.Score do
  alias Sift.Schema
  alias Sift.Schema.Field
  alias Sift.HTTP.Request

  @score_fields %{
    abuse_types: %Field{
      key: "abuse_types",
      type:
        {:list,
         {:enum,
          {"",
           [
             :payment_abuse,
             :account_abuse,
             :content_abuse,
             :promotion_abuse
           ]}}}
    }
  }
  def get_score(api_key, user_id, abuse_types \\ []) do
    with {:ok, url} <- score_url(api_key, user_id, abuse_types) do
      {:ok, %Request{url: url}}
    end
  end

  def rescore(api_key, user_id, abuse_types \\ []) do
    with {:ok, url} <- score_url(api_key, user_id, abuse_types) do
      {:ok, %Request{url: url, method: :post}}
    end
  end

  defp score_url(api_key, user_id, abuse_types) do
    params = %{abuse_types: abuse_types}

    with {:ok, fields} <- Schema.parse(params, @score_fields) do
      fields =
        case fields["abuse_types"] do
          nil -> fields
          [] -> Map.delete(fields, "abuse_types")
          value -> Map.put(fields, "abuse_types", Enum.join(value, ","))
        end
        |> Map.put("api_key", api_key)

      url = "https://api.sift.com/v205/users/#{user_id}/score?#{URI.encode_query(fields)}"
      {:ok, url}
    end
  end
end
