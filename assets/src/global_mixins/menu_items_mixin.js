export const menu_items_mixin = {
  data() {
    return {
      items: [{
          path: '/lista-users',
          icon: 'mdi-office-building',
          text: 'Users',
          user: [1]
        },
        {
          path: '/get-auth-user',
          icon: 'mdi-anchor',
          text: 'Auth',
          user: [1]
        }
      ]
    }
  }
}