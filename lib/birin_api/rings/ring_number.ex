defmodule BirinApi.Rings.RingNumber do
  use Ecto.Schema
  import Ecto.Changeset

  alias BirinApi.{
    Accounts.User,
    Rings.RingSeries
  }

  schema "ring_number" do
    field(:number, :string)
    field(:type, :string)
    belongs_to(:user, User)
    belongs_to(:ring_series, RingSeries)

    timestamps()
  end

  @doc false
  def changeset(ring_number, attrs) do
    ring_number
    |> cast(attrs, [:type, :number, :user_id, :ring_series_id])
    |> assoc_constraint(:ring_series)
    |> assoc_constraint(:user)
    |> validate_required([:type, :number])
  end
end
