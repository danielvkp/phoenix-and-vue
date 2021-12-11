import ListUsers from '../componentes/ListUsers.vue'
import AuthUser from '../componentes/AuthUser.vue'

const routes = [
  ...route('/lista-users', ListUsers, {
    Auth: true,
  }),
  ...route('/get-auth-user', AuthUser, {
    Auth: true,
  })
]

function route(path, component = Default, meta = {}) {
  return [{
    path,
    component,
    meta
  }]
}

export default routes