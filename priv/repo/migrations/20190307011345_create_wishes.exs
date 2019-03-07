defmodule Garland.Repo.Migrations.CreateWishes do
  use Ecto.Migration

  def change do
    create table(:wishes) do
      add :image, :string
      add :note, :string
      add :quantity, :integer
      add :title, :string
      add :url, :string
      add :bought, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:wishes, [:user_id])
  end
end
