import RiotControl from 'riotcontrol'
import MenuStore from './Store/MenuStore'
import MenuAction from './Action/MenuAction'
import request from 'superagent'

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
    createChannel(e) {
      e.preventDefault()
      let channel = {
        name: this.refs.name.value.trim(),
        slug: this.refs.slug.value.trim()
      }
      if ((channel.name != '') && (channel.slug != ''))
        this.clearForm()
        request.post('/channels', channel, (err, res) => {
          MenuAction.resetMenu()
        })
    }

    clearForm() {
      this.refs.name.value = ""
      this.refs.slug.value = ""
    }

    this.on('mount', () => {
      this.items = []
      MenuAction.resetMenu()
      RiotControl.on('UPDATED_MENU', () => {
        this.update({items: MenuStore.getMenu()})
      })
    })
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
