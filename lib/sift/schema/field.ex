defmodule Sift.Schema.Field do
  @moduledoc """
  Field specification
  """
  @enforce_keys [:key]
  defstruct key: nil, type: :string, required?: false, union: nil, union_required?: false

  @type t :: %__MODULE__{
          key: String.t(),
          type: atom() | {atom(), any()},
          required?: boolean(),
          union: atom() | {atom(), non_neg_integer()},
          union_required?: boolean()
        }
end
