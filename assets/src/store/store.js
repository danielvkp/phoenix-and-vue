import modulo_estado from './modulos/modulo_estado'
import Vue from "vue"
import Vuex from "vuex"

Vue.use(Vuex)

const store = new Vuex.Store({
    strict: false,

    modules: {
        estado: modulo_estado,
    },

})

export default store;