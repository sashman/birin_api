defmodule BirinApi.Rings.RingSeries do
  use Ecto.Schema
  import Ecto.Changeset


  schema "ring_series" do
    field :end_number, :string
    field :size, :integer
    field :start_number, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(ring_series, attrs) do
    ring_series
    |> cast(attrs, [:type, :size, :start_number, :end_number])
    |> validate_required([:type, :size, :start_number, :end_number])
  end
end
