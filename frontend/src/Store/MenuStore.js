import RiotControl from 'riotcontrol'
import request from 'superagent'

let _channels = []
let _current_channel = ''
let _menu = []

const _fetch_channels = () => {
  request.get('/channels', (err, res) => {
    _channels = res.body
    _update_menu()
  })
}

const _update_menu = (slug) => {
  if (slug) _current_channel = slug
  _menu = _channels.map( (channel) => {
    return {
      slug: channel.slug,
      name: channel.name,
      isActive: channel.slug == _current_channel
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
