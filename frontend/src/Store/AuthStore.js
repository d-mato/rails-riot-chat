const auth = {
  headers: {},
  signed_in: false
}

class AuthStore {
  constructor() {
    riot.observable(this)

    this.on('USER_SIGN_IN', this.sign_in)
  }
  getHeaders() { return auth.headers }
  isSignedIn() { return auth.signed_in }

  sign_in(user) {
    request.post('/auth/sign_in', user, (err, res) => {
      if (err) {
        this.trigger('FAILED_SIGN_IN')
        return console.log(err)
      }

      console.log(res)
      auth.headers = {
        'access-token': res.headers['access-token'],
        client: res.headers['client'],
        expiry: res.headers['expiry'],
        uid: res.headers['uid']
      }
      auth.signed_in = true

      this.trigger('USER_SIGNED_IN')
    })
  }
}

const store = new AuthStore()
export default store
