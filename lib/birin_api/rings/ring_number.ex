defmodule BirinApi.Rings.RingNumber do
  use Ecto.Schema
  import Ecto.Changeset

  alias BirinApi.{
    Rings.RingSeries
  }

  schema "ring_number" do
    field(:number, :string)
    field(:type, :string)
    belongs_to(:ring_series, RingSeries)
    has_many(:user, through: [:ring_series, :user])

    timestamps()
  end

  @doc false
  def changeset(ring_number, attrs) do
    ring_number
    |> cast(attrs, [:type, :number, :ring_series_id])
    |> assoc_constraint(:ring_series)
    |> validate_required([:type, :number])
    |> unique_constraint(:number)
  end
end
