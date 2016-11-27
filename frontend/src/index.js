// window.request = require('superagent').agent()

require('bootstrap/dist/css/bootstrap.css')
require('./css/animation.css')

require('./app.tag')
require('./sidebar.tag')
require('./home.tag')
require('./signin.tag')
require('./channel.tag')
require('./channels.tag')
require('./comments.tag')
require('./comment-form.tag')
require('./registration.tag')

riot.mount('*')

// Routes
import route from 'riot-route'
import MenuAction from './Action/MenuAction'

const menuAction = new MenuAction()

route('/', () => {
  riot.mount('main', 'home')
  menuAction.changePage('')
})

route('/registration', () => {
  riot.mount('main', 'registration')
  menuAction.changePage('registration')
})

route('/channels/*', (slug) => {
  riot.mount('main', 'channel', { slug } )
  menuAction.changePage(slug)
})

route.start(true)
