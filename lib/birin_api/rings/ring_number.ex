defmodule BirinApi.Rings.RingNumber do
  use Ecto.Schema
  import Ecto.Changeset
  alias BirinApi.Accounts.User


  schema "ring_number" do
    field :allocated_at, :naive_datetime
    field :number, :string
    field :received_at, :naive_datetime
    field :type, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(ring_number, attrs) do
    ring_number
    |> cast(attrs, [:type, :number, :received_at, :allocated_at, :user_id])
    |> validate_required([:type, :number, :received_at, :allocated_at, :user_id])
  end
end
