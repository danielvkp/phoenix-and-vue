defmodule Newapp.Repo.Migrations.CreateProyectoTable do
  use Ecto.Migration

  def change do
    create table(:proyecto) do
      add :name, :string, size: 150
      add :price, :double
      add :description, :string    
      timestamps()
    end
  end
end
