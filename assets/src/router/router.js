import VueRouter from 'vue-router'

import Inicio from '../base_components/inicio/Inicio.vue'
import rutas_pdf from '../modulos/pdf/rutas/rutas_pdf'


const base_routes = [
    ...route('/', Inicio, {}),
    ...rutas_pdf,
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

export default router
