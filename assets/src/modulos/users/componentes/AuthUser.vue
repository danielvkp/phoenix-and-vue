<template id="">
  <div class="">

    <h2 class="mb-4 blue-grey--text font-weight-light">LISTADO Usuarios</h2>
    <loader v-if="isloading"></loader>

    <v-row dense>
      <v-col cols="12" md="3">
        <v-btn @click="get_auth_user" class="white--text elevation-0" color="purple">get auth user</v-btn>
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
        chat: null,
      }
    },

    created() {

    },

    methods: {
      get_auth_user() {
        axios.get(`api/v1/get-auth-user`).then(res => {
          console.log(res.data)
          this.user = res.data
          Chat.init(MySocket, 'lobby')
        }, res => {})
      }
    },

    computed: {
      isloading() {
        return this.$store.getters.getloading
      }
    }
  }
</script>