<channels>
  <ul class="list-unstyled">
    <li each={items} class={isActive ? 'active' : ' '} ><a href="/#/channels/{slug}">{name}</a></li>
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
    const route = require('riot-route')

    route('/channels/*', (slug) => {
      let items = this.items.map( (item) => {
        item.isActive = (item.slug == slug)
        return item
      })
      this.update({items})
    })

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

  <style scoped>
    a, a:focus, a:active {
      color: #aaa;
      text-decoration: none;
    }
    a:hover {
      color: #fff;
      text-decoration: none;
    }
    li.active a {
      color: #fff;
      font-weight: bold;
    }
    ul {
      margin-left: 10px;
    }
  </style>

</channels>
