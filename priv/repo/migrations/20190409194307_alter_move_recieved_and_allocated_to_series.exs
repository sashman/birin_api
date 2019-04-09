defmodule BirinApi.Repo.Migrations.AlterMoveRecievedAndAllocatedToSeries do
  use Ecto.Migration

  def up do
    alter table(:ring_series) do
      add :received_at, :naive_datetime
      add :allocated_at, :naive_datetime
    end

    alter table(:ring_number) do
      remove :received_at
      remove :allocated_at
    end
  end

  def down do
    alter table(:ring_number) do
      add :received_at, :naive_datetime
      add :allocated_at, :naive_datetime
    end

    alter table(:ring_series) do
      remove :received_at
      remove :allocated_at
    end
  end
end
