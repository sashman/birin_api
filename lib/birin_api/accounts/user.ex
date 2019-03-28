defmodule BirinApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias BirinApi.Rings.RingNumber

  schema "users" do
    field :auth_id, :string
    field :email, :string
    field :license_number, :string
    field :name, :string
    has_many :rings, RingNumber

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:auth_id, :email, :name, :license_number])
    |> validate_required([:auth_id, :email])
    |> unique_constraint([:auth_id, :email, :license_number])
  end
end
