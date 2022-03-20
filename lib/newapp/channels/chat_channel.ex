defmodule NewappWeb.ChatChannel do
  use Phoenix.Channel

  def join("chat:" <> room_id, _params, socket) do
    {:ok, %{channel: "chat:#{room_id}"}, assign(socket, :room_id, room_id)}
  end

  def handle_in("request_message", %{"room_id" => room_id}, socket) do
    broadcast_from!(socket, "request_message", %{room_id: room_id})

    NewappWeb.Endpoint.broadcast_from!(self(), "chat:553", "request_message",  %{room_id: room_id})

    {:noreply, socket}

  end

  #defp insert_message(msg) do
  #  Blog.Message.changeset(%Blog.Message{}, msg) |> Blog.Repo.insert
  #end

end
