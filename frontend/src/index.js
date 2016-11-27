require('bootstrap/dist/css/bootstrap.css')
require('./css/animation.css')

require('./app.tag')
require('./sidebar.tag')
require('./home.tag')
require('./channel.tag')
require('./comments.tag')
require('./comment-form.tag')

riot.mount('*')

// Routes
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
