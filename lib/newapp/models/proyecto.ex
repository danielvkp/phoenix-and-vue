defmodule Newapp.Proyecto do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:name, :price, :description]}

  schema "proyecto" do
    field :name, :string
    field :price, :float
    field :description, :string
    timestamps()
   end

end
