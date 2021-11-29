import FormUsuario from '../componentes/FormUsuario'
import ListaUsuarios from '../componentes/ListaUsuarios'
import CargaUsuarios from '../componentes/CargaUsuarios'

const routes = [
    ...route('/guardar-usuario', FormUsuario, {
        Auth: true,
        req_admin: true
    }),
    ...route('/lista-usuarios', ListaUsuarios, {
        Auth: true,
        req_admin: true
    }),
    ...route('/guardar-multiples', CargaUsuarios, {
        Auth: true,
        req_admin: true
    }),
]

function route(path, component = Default, meta = {}) {
    return [{
        path,
        component,
        meta
    }]
}

export default routes