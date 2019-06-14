defmodule BirinApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias BirinApi.Rings.RingNumber

  schema "users" do
    field(:auth_id, :string)
    field(:email, :string)
    field(:license_number, :string)
    field(:name, :string)
    field(:initials, :string)
    has_many(:rings, RingNumber)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:auth_id, :email, :name, :license_number, :initials])
    |> validate_required([:auth_id, :email])
    |> unique_constraint(:auth_id)
    |> unique_constraint(:email)
    |> unique_constraint(:license_number)
    |> unique_constraint(:initials)
  end
end
