import AuthStore from './AuthStore'

let _comments = []
const _comments_path = (channel_id) => `/channels/${channel_id}/comments`
const _format_comment = (comment) => {
  comment.author_name = comment.author_name || 'anonymous'
  comment.created_at = moment(comment.created_at).format('MM/DD HH:mm')
  return comment
}

class CommentStore {
  constructor() {
    riot.observable(this)

    this.on('RELOAD_COMMENTS', this.fetch_comments)
    this.on('POST_COMMENT', this.post_comment)
    this.on('DELETE_COMMENT', this.delete_comment)
  }

  getComments() { return _comments }

  fetch_comments(channel_id) {
    request.get(_comments_path(channel_id)).end((err, res) => {
      _comments = res.body.map(_format_comment)
      this.trigger('RELOADED_COMMENTS')
    })
  }

  post_comment(comment, channel_id) {
    if (comment.body == '') {
      this.trigger('FAILED_POST_COMMENT', 'body is empty')
      return false
    }
    request.post(_comments_path(channel_id), comment).end((err, res) => {
      if (err) this.trigger('FAILED_POST_COMMENT', err)
      else {
        this.trigger('POSTED_COMMENT')
        _comments.push(_format_comment(res.body))
        this.trigger('RELOADED_COMMENTS')
      }
    })
  }

  delete_comment(comment_id) {
    request.delete(`/comments/${comment_id}`, (err, res) => {
      let index = _comments.findIndex( (comment) => comment.id == comment_id )
      _comments.splice(index, 1)
      if (!err) this.trigger('DELETED_COMMENT')
    })
  }
}

const store = new CommentStore()
export default store
