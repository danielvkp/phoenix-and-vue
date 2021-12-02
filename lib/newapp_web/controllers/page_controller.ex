defmodule NewappWeb.PageController do
  use NewappWeb, :controller
  import Ecto.Query, only: [from: 2]
  alias Newapp.User .{Repo, User}

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, _params) do
    send_resp conn, 200, Poison.encode!(%{mensaje: "success"})
  end

  def get_users(conn, _params)do
    paginate = from u in Newapp.User, select: u.email,
      limit: ^10,
      offset: ^((2-1) * 10)

    users = Newapp.Repo.all(paginate)

    send_resp conn, 200, Poison.encode!(users)
  end

end
