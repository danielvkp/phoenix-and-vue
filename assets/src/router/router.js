import VueRouter from 'vue-router'
import auth from '../auth/auth.js'

import Login from '../base_components/auth/Login.vue'
import Inicio from '../base_components/inicio/Inicio.vue'
import rutas_users from '../modulos/users/rutas/rutas_users'

const base_routes = [
  ...route('/login', Login),
  ...route('/', Inicio, {
    Auth: true,
  }),
  ...rutas_users,
]

const routes = [
  ...base_routes
]

const router = new VueRouter({
  routes
})

function route(path, component = Default, meta = {}) {
  return [{
    path,
    component,
    meta
  }]
}

router.beforeEach((to, from, next) => {
  if (to.meta.Auth) {
    if (!auth.authenticated()) {
      next({
        path: '/login',
        query: {
          redirect: to.fullPath
        }
      })
    } else {
      next()
    }
  } else {
    next()
  }
})

export default router