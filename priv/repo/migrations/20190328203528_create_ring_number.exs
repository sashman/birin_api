defmodule BirinApi.Repo.Migrations.CreateRingNumber do
  use Ecto.Migration

  def change do
    create table(:ring_number) do
      add :type, :string
      add :number, :string
      add :received_at, :naive_datetime
      add :allocated_at, :naive_datetime
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:ring_number, [:user_id])
  end
end
