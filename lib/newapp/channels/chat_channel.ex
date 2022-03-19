defmodule NewappWeb.ChatChannel do
  use Phoenix.Channel

  def join("chat:" <> room_id, _params, socket) do
    {:ok, %{channel: "chat:#{room_id}"}, assign(socket, :room_id, room_id)}
  end

  def handle_in("new_request", %{"room_id" => room_id}, socket) do
    #IO.puts(room_id)
    socket.assigns["553"]
    push socket, "chat:553:new_request", %{token: nil}

    broadcast_from!(socket, "new_request", %{room_id: "hola"})
    NewappWeb.Endpoint.broadcast_from!(self(), "chat:553", "new_request",  %{room_id: "hola"})


    {:noreply, socket}
  end

  #defp insert_message(msg) do
  #  Blog.Message.changeset(%Blog.Message{}, msg) |> Blog.Repo.insert
  #end

end
