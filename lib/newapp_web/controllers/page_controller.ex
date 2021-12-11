defmodule NewappWeb.PageController do
  use NewappWeb, :controller
  import Ecto.Query, only: [from: 2]
  alias Newapp.User .{Repo, User}
  alias Newapp.UserSeacher
  alias Newapp.Guardian

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def get_auth_user(conn, _params) do
    #{:ok, claims} = Newapp.Guardian.decode_and_verify(_params)
    maybe_user = Guardian.Plug.current_resource(conn)

    send_resp conn, 200, Poison.encode!(maybe_user)
  end

  def show(conn, _params) do
    send_resp conn, 200, Poison.encode!(%{mensaje: "success"})
  end

  def get_users(conn, params) do
    request = for {k, v} <- params, v != nil, into: %{}, do: {k, v}

    items = UserSeacher.search(request)

    send_resp conn, 200, Poison.encode!(items)
  end

end
