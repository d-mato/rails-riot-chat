import AuthStore from './AuthStore'

class ChannelsStore {
  constructor() {
    riot.observable(this)
  }

  fetchChannel(slug) {
    request.get(`/channels/${slug}`).end((err, res) => {
      if (err) this.trigger('FAIL_FETCH_CHANNEL')

      let channel = res.body
      channel.created_at = moment(channel.created_at).format('YYYY-MM-DD HH:mm:ss')
      this.trigger('FETCHED_CHANNEL', channel)
    })
  }

  updateChannel(id, params) {
    request.patch(`/channels/${id}`).send(params).end((err, res) => {
      if (!err) {
        this.trigger('UPDATED_CHANNEL', res.body)
      }
    })
  }

  deleteChannel(id) {
    request.delete(`/channels/${id}`).end((err, res) => {
      this.trigger('DELETED_CHANNEL')
    })
  }
}

const store = new ChannelsStore()
export default store
