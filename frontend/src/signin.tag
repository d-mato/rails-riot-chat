<signin>
  <div id="signin-box" class={active: opend}>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3>signin</h3>
      </div>
      <div class="panel-body">
        <form onsubmit={submit} if={!success}>
          <div class="form-group">
            <label>Email</label>
            <input ref="email" type="email" class="form-control" value="user@example.com"/>
          </div>

          <div class="form-group">
            <label>Password</label>
            <input ref="password" class="form-control" value="12345678"/>
          </div>

          <div class="form-group">
            <span class="btn btn-danger" onclick={close}>Cancel</span>
            <button type="submit" class="btn btn-success">Sign in</button>
          </div>
        </form>
        <div class="alert alert-success" show={success}>Signed in Successfully</div>
      </div>
    </div>
  </div>

  <style scoped>
    #signin-box {
      position: fixed;
      opacity: 0;
      width: 500px;
      left: 200px;
      top: -200px;
      z-index: 10;
      transition: all 0.3s;
    }
    #signin-box.active {
      opacity: 1;
      top: 0;
    }
  </style>

  toggle() { this.opend = !this.opend }
  close() { this.opend = false }
  submit(e) {
    e.preventDefault()
    const user = {
      email: this.refs.email.value,
      password: this.refs.password.value
    }
    request.post('/users/sign_in', {user}, (err, res) => {
      if (err) return console.log(err)

      console.log(res)
      this.update({success: true})
      setTimeout(() => {
        this.update({opend: false, success: false})
      }, 1500)
    })
  }
</signin>
