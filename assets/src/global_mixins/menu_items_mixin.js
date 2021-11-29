export const menu_items_mixin = {
    data() {
        return {
            items: [{
                    path: '/lista-pdf',
                    icon: 'mdi-office-building',
                    text: 'Listado',
                    user: [1]
                },
                {
                    path: '/nuevo-pdf',
                    icon: 'mdi-account-group',
                    text: 'Nuevo',
                    user: [1]
                },
            ]
        }
    },
}