defmodule Newapp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email,    :string, size: 40
      add :password, :string
      add :email_verified_at, :date
      add :role, :integer
      timestamps()
    end
  end
end
