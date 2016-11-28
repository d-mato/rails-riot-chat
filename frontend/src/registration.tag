<registration>
  <h1>Registration</h1>

  <form onsubmit={post}>
    <div class="form-group">
      <label>Email</label>
      <input ref="email" type="email" class="form-control"/>
    </div>

    <div class="form-group">
      <label>Password</label>
      <input ref="password" class="form-control"/>
    </div>

    <button type="submit" class="btn btn-success">Sign Up</button>

  </form>
  <div class="alert alert-success" show={this.success}>Sign up successfully!</div>
  <div class="alert alert-danger" show={this.error_messages}>
    <ul>
      <li each={msg in this.error_messages}>{msg}</li>
    </ul>
  </div>

  <style scoped>
    form { width: 300px; }
  </style>

  import RiotControl from 'riotcontrol'
  import AuthStore from './Store/AuthStore'
  import AuthAction from './Action/AuthAction'
  const authAction = new AuthAction()

  post(e) {
    e.preventDefault()
    const user = {
      email: this.refs.email.value,
      password: this.refs.password.value
    }
    authAction.sign_up(user)
  }

  RiotControl.on('USER_SIGNED_UP', () => {
    this.update({success: true})
    setTimeout(() => {location.href = '/#/'}, 2000)
  })
  RiotControl.on('FAILED_SIGN_UP', () => {
    this.update({error_messages: AuthStore.getErrors()})
  })
</registration>
