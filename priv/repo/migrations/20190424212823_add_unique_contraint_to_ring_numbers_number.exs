defmodule BirinApi.Repo.Migrations.AddUniqueContraintToRingNumbersNumber do
  use Ecto.Migration

  def change do
    create(unique_index(:ring_number, [:number]))
  end
end
