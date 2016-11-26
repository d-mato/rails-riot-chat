import RiotControl from 'riotcontrol'
import request from 'superagent'
import moment from 'moment'

let _comments = []

const _comments_path = (channel_id) => `/channels/${channel_id}/comments`

const _fetch_comments = (channel_id) => {
  request.get(_comments_path(channel_id), (err, res) => {
    _comments = res.body.map( (comment) => {
      comment.author_name = comment.author_name || 'anonymous'
      comment.created_at = moment(comment.created_at).format('MM/DD HH:mm')
      return comment
    })
    RiotControl.trigger('RELOADED_COMMENTS')
  })
}

const _post_comment = (comment, channel_id) => {
  if (comment.body == '') return false
  request.post(_comments_path(channel_id), comment, (err, res) => {
    if (!err) RiotControl.trigger('POSTED_COMMENT')
  })
}

const _delete_comment = (comment_id) => {
  request.delete(`/comments/${comment_id}`, (err, res) => {
    if (!err) RiotControl.trigger('DELETED_COMMENT')
    let index = _comments.findIndex( (comment) => comment.id == comment_id )
    _comments.splice(index, 1)
    RiotControl.trigger('RELOADED_COMMENTS')
  })
}

class CommentStore {
  constructor() {
    riot.observable(this)

    this.on('RELOAD_COMMENTS', _fetch_comments)
    this.on('POST_COMMENT', _post_comment)
    this.on('DELETE_COMMENT', _delete_comment)
  }
  getComments() { return _comments }
}

const store = new CommentStore()
RiotControl.addStore(store)

export default store
