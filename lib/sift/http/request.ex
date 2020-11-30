defmodule Sift.HTTP.Request do
  defstruct [:url, :body, :headers, :method]

  @type t :: %{
          url: String.t(),
          body: map(),
          headers: [tuple],
          method: :post | :get
        }
end
