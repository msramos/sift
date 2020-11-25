defmodule Sift.Base do
  alias Sift.Base.Payload

  def execute(event, params, specs) do
    with {:ok, parsed} <- Payload.parse(params, event, specs) do
      {:ok, parsed}
    else
      error -> error
    end
  end
end
