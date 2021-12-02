defmodule Newapp.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:id, :email, :password]}
  schema "users" do
    field :email, :string
    field :password, :string
    field :email_verified_at, :date
    field :role, :integer
    timestamps()
   end

  def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, [:email, :password])
      |> validate_required([:email, :password])
      |> put_password_hash
    end

  defp put_password_hash(changeset) do
   case changeset do
       %Ecto.Changeset{valid?: true, changes: %{password: password}}
         ->
           put_change(changeset, :password, Comeonin.Bcrypt.hashpwsalt(password))
       _ ->
         changeset
    end
   end
end
