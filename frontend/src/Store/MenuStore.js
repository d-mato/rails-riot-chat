import AuthStore from './AuthStore'

let _channels = []
let _menu = {}

class MenuStore {
  constructor() {
    riot.observable(this)

    this.on('RELOAD_MENU', this.fetch_channels)
    this.on('CHANGE_PAGE', this.update_menu)
  }

  getMenu() { return _menu }

  fetch_channels() {
    request.get('/channels').end((err, res) => {
      _channels = res.body
      this.update_menu(_menu.current_page)
    })
  }

  update_menu(slug) {
    _menu.current_page = slug
    _menu.channels = _channels.map( (channel) => {
      return {
        slug: channel.slug,
        name: channel.name,
        isActive: channel.slug == _menu.current_page
      }
    })
    this.trigger('UPDATED_MENU')
  }
}

const store = new MenuStore()
export default store
