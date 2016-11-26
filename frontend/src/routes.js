require('./home.tag')
require('./channel.tag')
import route from 'riot-route'
import MenuAction from './Action/MenuAction'

const menuAction = new MenuAction()

route('/', () => {
  riot.mount('main', 'home')
  menuAction.changePage('')
})

route('/channels/*', (slug) => {
  riot.mount('main', 'channel', { slug } )
  menuAction.changePage(slug)
})
route.start(true)
