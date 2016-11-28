import RiotControl from 'riotcontrol'
import AuthStore from './Store/AuthStore'
import MenuStore from './Store/MenuStore'
import MenuAction from './Action/MenuAction'

const menuAction = new MenuAction()

<sidebar>
  <h2><a href="/#/">rails-riot-chat</a></h2>

  <a href="#" onclick={tags.signin.toggle} show={!signed_in}>Sign in <span class="glyphicon glyphicon-user"></span></a>
  <a href="#" show={signed_in}>ログイン中<span class="glyphicon glyphicon-user"></span></a>
  <signin></signin>

  <h3 class={active: (menu.current_page == '')}><a href="/#/">Home</a></h3>

  <h3>Channels</h3>
  <channels items={menu.channels}></channels>

  <hr/>

  <a href="#" onclick={toggleChannelForm}>Add channel <span class="glyphicon glyphicon-plus-sign"></span></a>
  <form onsubmit={createChannel} ref="channelForm" if={form_shown}>
    <label>name:</label> <input class="form-control" ref="name" onkeyup={autoFillSlug} />
    <label>slug:</label> <input class="form-control" ref="slug"/>
    <button class="btn btn-primary" type="submit">Create</button>
  </form>

  <hr/>

  <h3 class={active: (menu.current_page == 'registration')}><a href="/#/registration">User Registration</a></h3>

  <style scoped>
    span, label {
      color: #aaa;
    }
    h2 a {
      color: #fff;
      font-size: 2.2rem;
    }
    h3 {
      font-size: 1.1em;
      color: #aaa;
      margin: 5px 0;
    }

    a, a:focus, a:active {
      color: #aaa;
      text-decoration: none;
      display: block;
    }
    a:hover {
      color: #fff;
      text-decoration: none;
    }
    .active a {
      color: #fff;
      font-weight: bold;
    }

  </style>

  createChannel(e) {
    e.preventDefault()
    let channel = {
      name: this.refs.name.value.trim(),
      slug: this.refs.slug.value.trim()
    }
    if ((channel.name != '') && (channel.slug != '')) {
      request.post('/channels', channel, (err, res) => {
        this.form_shown = false
        if (err) return console.log(err)
        menuAction.reloadMenu()
        location.href = `/#/channels/${res.body.slug}`
      })
    }
  }

  toggleChannelForm(e) {
    e.preventDefault()
    this.form_shown = !this.form_shown
  }

  autoFillSlug() {
    let slug = this.refs.name.value.toLowerCase().replace(/[\-\s]/g, '_').replace(/[^\w_]/g, '')
    this.refs.slug.value = slug
  }

  this.menu = {}
  this.on('mount', () => {
    RiotControl.on('UPDATED_MENU', () => {
      this.update({menu: MenuStore.getMenu()})
    })
    RiotControl.on('USER_SIGNED_IN', () => {
      this.update({signed_in: true})
    })
    menuAction.reloadMenu()
  })
</sidebar>
