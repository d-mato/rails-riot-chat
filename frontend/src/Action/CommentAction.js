import RiotControl from 'riotcontrol'

export default class CommentAction {
  reloadComments() {
    if (!this.channel_id) throw 'channel_id is not set !'
    RiotControl.trigger('RELOAD_COMMENTS', this.channel_id)
  }
  postComment(comment) {
    RiotControl.trigger('POST_COMMENT', comment, this.channel_id)
  }
  deleteComment(comment_id) {
    RiotControl.trigger('DELETE_COMMENT', comment_id)
  }
}
