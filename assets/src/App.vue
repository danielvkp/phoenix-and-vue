<template>
  <div id="app">
    <v-app dark>
      <v-main>
        <v-container>

          <v-btn @click="coso = !coso" class="white--text" color="blue">nuevo</v-btn>
          <h1 v-if="coso">Prueba Vuetify</h1>
        </v-container>
      </v-main>
    </v-app>
  </div>
</template>

<script>
  export default {
    name: 'app',
    data() {
      return {
        coso: false,
        mensaje: 'hola bebes'
      }
    }
  }
</script>