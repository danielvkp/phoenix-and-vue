<template id="">
  <div class="">

    <h2 class="mb-4 blue-grey--text font-weight-light">LISTADO Usuarios</h2>
    <loader v-if="isloading"></loader>

    <v-row dense>
      <v-col cols="12" md="3">
        <v-btn @click="get_auth_user" class="white--text elevation-0" color="purple">connect to private socket</v-btn>
      </v-col>
    </v-row>

    <v-row dense>
      <v-col cols="12" md="3">
        <v-text-field v-model="chat.room" outlined label=""></v-text-field>
        <v-btn @click="send_request" class="white--text elevation-0" color="orange">send request</v-btn>
      </v-col>
    </v-row>



  </div>
</template>

<script>
  import MySocket from '../../../socket/socket'
  import Chat from '../../../socket/chat'
  export default {
    data() {
      return {
        user: {},
        chat: {
          room: 1
        },
        my_chat: null
      }
    },

    created() {

    },

    methods: {
      listen_to_socket(channel, channel_name) {
        channel.on(`request_message`, payload => {
          console.log(payload)
          this.$toast.sucs('llego algo')
        })
      },

      get_auth_user() {
        axios.get(`api/v1/get-auth-user`).then(res => {
          this.user = res.data
          this.my_chat = Chat.init(MySocket, res.data.id)
          this.listen_to_socket(this.my_chat, res.data.id)
        }, res => {})
      },

      send_request() {
        this.my_chat.push("request_message", {
          room_id: this.chat.room,
        })
      }
    },

    computed: {
      isloading() {
        return this.$store.getters.getloading
      }
    }
  }
</script>