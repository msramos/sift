defmodule Sift.HTTP.Request do
  @enforce_keys [:url]
  defstruct url: nil, body: nil, headers: [], method: :get

  @type t :: %{
          url: String.t(),
          body: map() | nil,
          headers: [tuple],
          method: :post | :get
        }
end
