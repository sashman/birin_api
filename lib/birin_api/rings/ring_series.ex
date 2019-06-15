defmodule BirinApi.Rings.RingSeries do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ring_series" do
    field(:end_number, :string)
    field(:size, :integer)
    field(:start_number, :string)
    field(:type, :string)
    field(:received_at, :naive_datetime)
    field(:allocated_at, :naive_datetime)
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(ring_series, attrs) do
    ring_series
    |> cast(attrs, [
      :type,
      :size,
      :start_number,
      :end_number,
      :received_at,
      :allocated_at,
      :user_id
    ])
    |> assoc_constraint(:user)
    |> validate_required([:type, :size, :start_number, :end_number])
  end
end
