const auth = {
  headers: {},
  signed_in: false
}
let errors = []

const set_auth_headers = (res) => {
  auth.headers = {
    'access-token': res.headers['access-token'],
    client: res.headers['client'],
    expiry: res.headers['expiry'],
    uid: res.headers['uid']
  }
  auth.signed_in = true
}

class AuthStore {
  constructor() {
    riot.observable(this)

    this.on('USER_SIGN_IN', this.sign_in)
    this.on('USER_SIGN_UP', this.sign_up)
  }
  getHeaders() { return auth.headers }
  isSignedIn() { return auth.signed_in }
  getErrors() { return errors }

  sign_in(user) {
    request.post('/auth/sign_in', user, (err, res) => {
      if (err) {
        this.trigger('FAILED_SIGN_IN')
        return console.log(err)
      }

      console.log(res)
      set_auth_headers(res)
      this.trigger('USER_SIGNED_IN')
    })
  }

  sign_up(user) {
    request.post('/auth', user, (err, res) => {
      if (err) console.log(err)
      if (res.body && res.body.errors) {
        errors = res.body.errors.full_messages
        this.trigger('FAILED_SIGN_UP')
      }
      if (res.body.status && res.body.status == 'success') {
        set_auth_headers(res)
        this.trigger('USER_SIGNED_UP')
        this.trigger('USER_SIGNED_IN')
      }
    })
  }
}

const store = new AuthStore()
export default store
