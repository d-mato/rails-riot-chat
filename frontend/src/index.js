window.request = superagent

// window.request = (RequestConstructor, method, url) => {
//   return RequestConstructor('GET', method).set('client', auth.client).set('access-token', auth.access_token).end(url);
// }
// window.request.get = (url) => {
//   return superagent.get(url)
// }
// window.request.get = function(url) {
//   return superagent.get(url).set('client', auth.client).set('access-token', auth.access_token)
// };;

import RiotControl from 'riotcontrol'

// Stores
import AuthStore from './Store/AuthStore'
import ChannelsStore from './Store/ChannelsStore'
import CommentStore from './Store/CommentStore'
import MenuStore from './Store/MenuStore'
RiotControl.addStore(AuthStore)
RiotControl.addStore(ChannelsStore)
RiotControl.addStore(CommentStore)
RiotControl.addStore(MenuStore)

// Tags
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
