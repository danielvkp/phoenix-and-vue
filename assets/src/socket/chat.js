let Chat = {
  init(socket, channel_name) {
    let channel = socket.channel(`chat:${channel_name}`, {})

    channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully", resp)
      })
      .receive("error", resp => {
        console.log("Unable to join", resp)
      })

    return channel
  }
}

export default Chat