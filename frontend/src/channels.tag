import MenuAction from './Action/MenuAction'
import request from 'superagent'

const menuAction = new MenuAction()

<channels>
  <ul class="list-unstyled">
    <li each={opts.items} class={isActive ? 'active' : ' '} ><a href="/#/channels/{slug}">{name}</a></li>
  </ul>

  <hr/>

  <span>Add channel</span>
  <form onSubmit={createChannel}>
    <label>name:</label> <input type="text" ref="name" onkeyup={autoFillSlug} />
    <label>slug:</label> <input type="text" ref="slug"/>
    <button class="btn btn-primary" type="submit">Create</button>
  </form>

  <script>
    createChannel(e) {
      e.preventDefault()
      let channel = {
        name: this.refs.name.value.trim(),
        slug: this.refs.slug.value.trim()
      }
      if ((channel.name != '') && (channel.slug != '')) {
        this.clearForm()
        request.post('/channels', channel, (err, res) => {
          menuAction.reloadMenu()
          location.href = `/#/channels/${res.body.slug}`
        })
      }
    }

    clearForm() {
      this.refs.name.value = ""
      this.refs.slug.value = ""
    }

    autoFillSlug() {
      let slug = this.refs.name.value.toLowerCase().replace(/[\-\s]/g, '_').replace(/[^\w_]/g, '')
      this.refs.slug.value = slug
    }
  </script>

  <style scoped>
  </style>

</channels>
