defmodule BirinApi.Repo.Migrations.AlterMoveUserReferenceToRingSeries do
  use Ecto.Migration

  def up do
    alter table(:ring_series) do
      add(:user_id, references(:users, on_delete: :nothing))
    end

    create(index(:ring_series, [:user_id]))

    alter table(:ring_number) do
      remove(:user_id)
    end

    drop_if_exists(index(:ring_number, [:user_id]))
  end

  def down do
    alter table(:ring_number) do
      add(:user_id, references(:users, on_delete: :nothing))
    end

    create(index(:ring_number, [:user_id]))

    alter table(:ring_series) do
      remove(:user_id)
    end

    drop_if_exists(index(:ring_series, [:user_id]))
  end
end
