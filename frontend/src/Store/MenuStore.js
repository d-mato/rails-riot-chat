import RiotControl from 'riotcontrol'
import request from 'superagent'

let _channels = []
let _menu = {}

const _fetch_channels = () => {
  request.get('/channels', (err, res) => {
    _channels = res.body
    _update_menu(_menu.current_page)
  })
}

const _update_menu = (slug) => {
  _menu.current_page = slug
  _menu.channels = _channels.map( (channel) => {
    return {
      slug: channel.slug,
      name: channel.name,
      isActive: channel.slug == _menu.current_page
    }
  })
  RiotControl.trigger('UPDATED_MENU')
}

class MenuStore {
  constructor() {
    riot.observable(this)

    this.on('RELOAD_MENU', _fetch_channels)
    this.on('CHANGE_PAGE', _update_menu)
  }
  getMenu() { return _menu }
}

const store = new MenuStore()
RiotControl.addStore(store)

export default store
