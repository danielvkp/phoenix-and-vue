import router from '../router/router.js'
import store from '../store/store.js'

export default {
  user: {
    authenticated: false,
  },

  signin: function(user) {
    axios.post('api/signin', user).then(res => {
      console.log(res.data.token)
      localStorage.setItem('auth_token', res.data.token)
      this.user.authenticated = true
      axios.defaults.headers.common['Authorization'] = ' Bearer ' + res.data.token
      router.push('/')
    }).catch(error => {

    })
  },

  dispatchUser: function(data) {
    store.dispatch('setAuth', true)
  },

  setLocalStorage: function(data) {
    localStorage.setItem('auth_token', data.token)
  },

  logout: function() {
    localStorage.removeItem('auth_token')
    router.push('/login')
  },

  setDefault: function() {
    return {
      name: '...',
    }
  },

  authenticated: function() {
    return this.check()
  },

  check: function() {
    return (localStorage.getItem('auth_token') !== null) ? true : false
  }
}