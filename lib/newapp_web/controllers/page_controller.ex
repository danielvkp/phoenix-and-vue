defmodule NewappWeb.PageController do
  use NewappWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, _params) do
    send_resp conn, 200, Poison.encode!(%{mensaje: "success"})
  end

end
