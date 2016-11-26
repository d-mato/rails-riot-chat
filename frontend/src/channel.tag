import RiotControl from 'riotcontrol'
import CommentStore from './Store/CommentStore'
import CommentAction from './Action/CommentAction'
import MenuAction from './Action/MenuAction'
import request from 'superagent'
import moment from 'moment'

const commentAction = new CommentAction()
const menuAction = new MenuAction()

<channel>
  <div show={loading} class="loading-filter">
    <div class="alert alert-info"><span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span> Loading ...</div>
  </div>

  <div class="alert alert-danger" show={error}>Cannot find channel !</div>

  <virtual if={channel}>
    <div class="row">
      <h2 class="channel_name col-xs-7">
        Channel:
        <virtual show={!editing_channnel_name}>
          <span class="" onclick={editChannelName}>{channel.name}</span>
          <a onclick={confirmDelete} class="glyphicon glyphicon-remove" href="#"></a>
        </virtual>

        <input value={channel.name} show={editing_channnel_name} onchange={updateChannelName} onblur={updateChannelName}/>
      </h2>

      <div class="col-xs-4 channel-stats">
        <h4>Channel Stats</h4>
        <ul class="list-unstyled">
          <li><small>Created: {channel.created_at}</small></li>
          <li><small if={comments}>Total comments: {comments.length}</small></li>
        </ul>
      </div>
    </div>

    <div class="alert alert-warning" show={comments && !comments.length}>No comments!</div>
    <ul class="comments list-unstyled">
      <li each={comments}>
        <div>
          <strong>{author_name}</strong> <span>{created_at}</span>
          <a onclick={deleteComment} class="glyphicon glyphicon-remove" href="#"></a>
        </div>
        <pre>{body}</pre>
      </li>
    </ul>

    <div class="footer">
      <button class="btn btn-default btn-sm" onclick={openForm}>Post comment</button>
    </div>
  </virtual>

  <div class="panel panel-default" id="form-panel" if={editing}>
    <div class="panel-heading">Post comment <span onclick={closeForm} class="btn glyphicon glyphicon-remove pull-right" style="padding:0"></span></div>
    <form class="panel-body" onSubmit={postComment}>
      <label>name:</label> <input ref="author_name" class="form-control" placeholder="anonymous"/>
      <label>comment:</label>
      <textarea ref="body" class="form-control" rows="3"/>
      <button class="btn btn-primary" type="submit" ref="submit_btn">Post</button>
    </form>
  </div>

  <script>
    postComment(e) {
      e.preventDefault()
      let comment = {
        author_name: this.refs.author_name.value.trim(),
        body: this.refs.body.value.trim()
      }
      this.refs.submit_btn.disabled = true
      commentAction.postComment(comment)
    }

    confirmDelete(e) {
      e.preventDefault()
      if (confirm('Are you sure to delete this channel ?'))
        request.delete(`/channels/${this.channel.id}`, (err, res) => {
          location.href = '/#/'
          menuAction.reloadMenu()
        })
    }

    deleteComment(e) {
      e.preventDefault()
      commentAction.deleteComment(e.item.id)
    }

    openForm() { this.editing = true }
    closeForm() { this.editing = false }

    scrollToBottom() {
      let block = document.querySelector('ul.comments')
      block.scrollTop = block.scrollHeight
    }

    editChannelName(e) {
      this.editing_channnel_name = true
    }

    updateChannelName(e) {
      this.editing_channnel_name = false
      if (this.channel.name == e.target.value) return false
      request.patch(`/channels/${this.channel.id}`, {name: e.target.value}, (err, res) => {
        if (!err) {
          this.update({channel: res.body})
          menuAction.reloadMenu()
        }
      })
    }

    this.on('mount', () => {
      this.loading = true
      request.get(`/channels/${opts.slug}`, (err, res) => {
        if (err) return this.update({error: true, loading: false})

        let channel = res.body
        channel.created_at = moment(channel.created_at).format('YYYY-MM-DD HH:mm:ss')
        this.update({channel: res.body})
        commentAction.channel_id = this.channel.id

        commentAction.reloadComments()
      })

      RiotControl.on('RELOADED_COMMENTS', () => {
        this.update({comments: CommentStore.getComments(), loading: false})
        this.scrollToBottom()
      })

      RiotControl.on('POSTED_COMMENT', () => {
        this.closeForm()
      })

      RiotControl.on('FAILED_POST_COMMENT', (err) => {
        this.refs.submit_btn.disabled = false
        console.log(err)
      })

      RiotControl.on('DELETED_COMMENT', () => {
        this.update({comments: CommentStore.getComments()})
      })
    })

    this.on('unmount', () => {
      RiotControl.off('RELOADED_COMMENTS')
      RiotControl.off('POSTED_COMMENT')
      RiotControl.off('FAILED_POST_COMMENT')
      RiotControl.off('DELETED_COMMENT')
    })
  </script>

  <style scoped>
    .loading-filter {
      width: 100%;
      height: 100%;
      background-color: rgba(255, 255, 255, 0.7);
      position: absolute;
      margin-left: -15px;
      z-index: 2;
    }
    .loading-filter .alert {
      text-align: center;
      width: 200px;
      margin: 20% auto;
    }

    h2.channel_name { cursor: pointer; }
    h2.channel_name .glyphicon-remove { font-size: 15px; display: none; }
    h2.channel_name:hover .glyphicon-remove { display: inline ; }

    .channel-stats h4 {
      margin: 0;
      font-size: 1.5rem;
    }
    .channel-stats ul {
      margin-left: 15px;
    }

    ul.comments {
      overflow-y: scroll;
      max-height: 80vh;
      padding: 20px;
      margin-right: -15px;
    }
    ul.comments li .glyphicon-remove { display: none; }
    ul.comments li:hover .glyphicon-remove { display: inline; }

    #form-panel {
      position: fixed;
      bottom: 0;
      width: 500px;
    }
  </style>
</channel>
