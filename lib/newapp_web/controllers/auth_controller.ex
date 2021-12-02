defmodule NewappWeb.AuthController do
  use NewappWeb, :controller
  alias Newapp.User
  alias Newapp.Accounts
  alias Newapp.Repo
  #use Guardian, otp_app: :Blog

  def sign_in(conn,  %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        send_resp conn, 200, Poison.encode!(%{token: token})
      _ ->
      send_resp conn, 401, Poison.encode!(%{error: :unauthorized})
    end
  end

end
