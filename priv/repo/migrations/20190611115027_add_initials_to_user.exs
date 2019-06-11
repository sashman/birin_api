defmodule BirinApi.Repo.Migrations.AddInitialsToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:initials, :string)
    end

    create(unique_index(:users, [:initials]))
  end
end
