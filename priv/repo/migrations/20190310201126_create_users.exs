defmodule BirinApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :auth_id, :string
      add :email, :string
      add :name, :string
      add :license_number, :string

      timestamps()
    end

    create unique_index(:users, [:auth_id])
    create unique_index(:users, [:email])
    create unique_index(:users, [:license_number])
  end
end
