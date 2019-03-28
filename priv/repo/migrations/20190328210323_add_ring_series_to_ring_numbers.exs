defmodule BirinApi.Repo.Migrations.AddRingSeriesToRingNumbers do
  use Ecto.Migration

  def change do
    alter table(:ring_number) do
      add :ring_series_id, references(:ring_series, on_delete: :nothing)
    end
  end
 
end
