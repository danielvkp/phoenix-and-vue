import FormPDF from '../componentes/FormPDF.vue'
import ListaPDF from '../componentes/ListaPDF'

const routes = [
    ...route('/nuevo-pdf', FormPDF, {
        Auth: true,
    }),
    ...route('/lista-pdf', ListaPDF, {
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