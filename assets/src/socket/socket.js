import {
  Socket
} from "phoenix"

let MySocket = new Socket("/socket", {
  params: {
    token: window.userToken
  }
})

MySocket.connect()

export default MySocket