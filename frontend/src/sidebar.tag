import RiotControl from 'riotcontrol'
import MenuStore from './Store/MenuStore'
import MenuAction from './Action/MenuAction'

const menuAction = new MenuAction()

require('./channels.tag')

<sidebar>
  <h2><a href="/#/">rails-riot-chat</a></h2>

  <h3 class={menu.current_page == '' ? 'active' : ' '}><a href="/#/">Home</a></h3>

  <h3>Channels</h3>
  <channels items={menu.channels}></channels>

  <script>
    this.menu = {}
    this.on('mount', () => {
      menuAction.reloadMenu()
      RiotControl.on('UPDATED_MENU', () => {
        this.update({menu: MenuStore.getMenu()})
      })
    })
  </script>

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
    ul {
      margin-left: 10px;
    }

  </style>
</sidebar>
