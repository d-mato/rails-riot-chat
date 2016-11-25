<channels>
  <ul>
    <li each={items}><a href="/#/channels/{slug}">{name}</a></li>
  </ul>

  <hr/>

  <span>Add channel</span>
  <form onSubmit={createChannel}>
    <label>name:</label> <input type="text" ref="name"/>
    <label>slug:</label> <input type="text" ref="slug"/>
    <button class="btn btn-primary" type="submit">Create</button>
  </form>

  <script>
    const request = require('superagent')

    fetchChannels() {
      request.get('/channels', (err, res) => this.update({items: res.body}) )
    }

    createChannel(e) {
      e.preventDefault()
      let channel = {
        name: this.refs.name.value.trim(),
        slug: this.refs.slug.value.trim()
      }
      if ((channel.name != '') && (channel.slug != ''))
        request.post('/channels', channel, (err, res) => {
          this.fetchChannels()
          this.clearForm()
        })
    }

    clearForm() {
      this.refs.name.value = ""
      this.refs.slug.value = ""
    }

    this.items = []
    this.fetchChannels()
  </script>

</channels>
