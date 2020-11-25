defmodule Sift.Base.Field do
  @moduledoc """
  Field specification
  """
  @enforce_keys [:key]
  defstruct key: nil, type: :string, required?: false, group: nil, group_required?: false

  @type t :: %__MODULE__{
          key: String.t(),
          type: :string | :browser | :app | :address | {:enum, [:atom]},
          required?: boolean(),
          group: atom() | {atom(), non_neg_integer()},
          group_required?: boolean()
        }
end
