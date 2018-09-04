defmodule Tracker.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :family_name, :string
      add :given_name, :string
      add :age, :integer
      add :weight, :integer
      add :image, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
