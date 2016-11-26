import RiotControl from 'riotcontrol'

let _comments = []

const _comments_path = (channel_id) => `/channels/${channel_id}/comments`

const _format_comment = (comment) => {
  comment.author_name = comment.author_name || 'anonymous'
  comment.created_at = moment(comment.created_at).format('MM/DD HH:mm')
  return comment
}

const _fetch_comments = (channel_id) => {
  request.get(_comments_path(channel_id), (err, res) => {
    _comments = res.body.map(_format_comment)
    RiotControl.trigger('RELOADED_COMMENTS')
  })
}

const _post_comment = (comment, channel_id) => {
  if (comment.body == '') {
    RiotControl.trigger('FAILED_POST_COMMENT', 'body is empty')
    return false
  }
  request.post(_comments_path(channel_id), comment, (err, res) => {
    if (err) RiotControl.trigger('FAILED_POST_COMMENT', err)
    else {
      RiotControl.trigger('POSTED_COMMENT')
      _comments.push(_format_comment(res.body))
      RiotControl.trigger('RELOADED_COMMENTS')
    }
  })
}

const _delete_comment = (comment_id) => {
  request.delete(`/comments/${comment_id}`, (err, res) => {
    let index = _comments.findIndex( (comment) => comment.id == comment_id )
    _comments.splice(index, 1)
    if (!err) RiotControl.trigger('DELETED_COMMENT')
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
