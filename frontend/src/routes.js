require('./channel.tag')
const route = require('riot-route')

route('/channels/*', (slug) => {
  riot.mount('main', 'channel', { slug } )
})
route.start(true)
