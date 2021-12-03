 window._ = require('lodash')
 import Vue from 'vue'

 window.Vue = require('vue')

 //import VuetifyToast from 'vuetify-toast-snackbar-ng'

 import setup from './interceptors/interceptors.js'
 setup()

 import VueRouter from 'vue-router'
 Vue.use(VueRouter)

 import Loader from './base_components/base/Loader.vue'
 Vue.component('loader', Loader)

 window.axios = require('axios')

 axios.defaults.headers.common['Content-Type'] = 'application/json'
 axios.defaults.headers.common['X-CSRF-TOKEN'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
 axios.defaults.headers.common.Authorization = `Bearer ${localStorage.getItem('auth_token')}`
 axios.defaults.withCredentials = true;

 /*Vue.use(VuetifyToast, {
     x: 'right',
     y: 'top',
     color: 'info',
     icon: 'mdi-info',
     timeout: 3000,
     dismissable: true,
     autoHeight: false,
     multiLine: false,
     vertical: false,
     shorts: {
       error: {
         color: 'red'
       },
       sucs: {
         color: 'green'
       },
       warn: {
         color: 'orange'
       }
     },
     property: '$toast'
   })
   */