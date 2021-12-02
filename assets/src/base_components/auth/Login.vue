<template>
  <div class="">

    <div class="my-login">
      <v-form>
        <v-container>


          <loader v-if="isloading"></loader>

          <v-row dense>
            <v-col cols="12" md="4" offset-md="4">

              <v-text-field outlined dense prepend-icon="mdi-account" v-model="user.email" small placeholder="Email" required></v-text-field>
              <v-text-field outlined dense @click:prepend="show1 = !show1" :prepend-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'" v-model="user.password" small placeholder="Contraseña" required :type="show1 ? 'text' : 'password'">
              </v-text-field>

              <v-row dense justify="center">
                <v-btn @click="doLogin" :disabled="isloading" color="success" dark class="elevation-0">Iniciar sesion</v-btn>
              </v-row>

            </v-col>
          </v-row>

        </v-container>
      </v-form>
    </div>
  </div>
</template>

<script>
  import auth from '../../auth/auth.js'
  export default {

    data() {
      return {
        user: {
          email: 'danielvkp@live.com',
          password: 'admin'
        },
        show1: true
      }
    },
    methods: {
      doLogin() {
        auth.signin(this.user)
      }
    },
    computed: {
      isloading: function() {
        return this.$store.getters.getloading
      },
    }
  }
</script>