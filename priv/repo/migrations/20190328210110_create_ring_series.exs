defmodule BirinApi.Repo.Migrations.CreateRingSeries do
  use Ecto.Migration

  def change do
    create table(:ring_series) do
      add :type, :string
      add :size, :integer
      add :start_number, :string
      add :end_number, :string

      timestamps()
    end

  end
end
