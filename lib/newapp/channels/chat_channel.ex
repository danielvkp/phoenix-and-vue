defmodule NewappWeb.ChatChannel do
  use Phoenix.Channel

  def join("chat:" <> room_id, _params, socket) do
    {:ok, %{channel: "chat:#{room_id}"}, assign(socket, :room_id, room_id)}
  end
  
  def handle_in("new_message", payload, socket) do
    room_id = socket.assigns[:room_id]
    broadcast! socket, "chat:#{room_id}:new_message_added", payload
    {:noreply, socket}
  end

  #defp insert_message(msg) do
  #  Blog.Message.changeset(%Blog.Message{}, msg) |> Blog.Repo.insert
  #end

end
