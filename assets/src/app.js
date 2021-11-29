require("./bootstrap")
import Vue from 'vue'

window.Vue = require("vue")

import vuetify from "./plugins/vuetify"
import Main from "./base_components/main/Main.vue"
import router from "./router/router.js"
import store from "./store/store.js"

new Vue({
  el: "#app",
  vuetify,
  router,
  store,
  template: '<Main/>',
  components: {
    Main
  },
});