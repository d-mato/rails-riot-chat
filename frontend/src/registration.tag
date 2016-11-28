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

  <style scoped>
    form { width: 300px; }
  </style>

  post(e) {
    e.preventDefault()
    const user = {
      email: this.refs.email.value,
      password: this.refs.password.value
    }
    request.post('/auth', user, (err, res) => {
      if (err) return console.log(err)
      console.log(res.body)
    })
  }
</registration>
