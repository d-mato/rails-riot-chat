require('./channel.tag')
import route from 'riot-route'
import MenuAction from './Action/MenuAction'

route('/channels/*', (slug) => {
  riot.mount('main', 'channel', { slug } )
  MenuAction.changePage(slug)
})
route.start(true)
