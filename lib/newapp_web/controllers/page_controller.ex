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

  def get_users(conn, params)do
    items = Newapp.User |> Newapp.Repo.paginate(params)
    #%{entries: entries, metadata: metadata}
    send_resp conn, 200, Poison.encode!(items)
  end

end
