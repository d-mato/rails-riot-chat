<channel>
  <div show={!channel || !comments} class="loading-filter">
    <div class="alert alert-info"><span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span> Loading ...</div>
  </div>

  <virtual if={channel}>
    <div class="row">
      <h2 class="channel_name col-xs-8">
        Channel: {channel.name}
        <a onClick={confirmDelete} class="glyphicon glyphicon-remove" href="#"></a>
      </h2>
      <div class="col-xs-4">
        <small>Created_at: {channel.created_at}</small>
      </div>
    </div>

    <div class="alert alert-warning" show={comments && !comments.length}>No comments!</div>
    <ul class="comments list-unstyled">
      <li each={comments}>
        <div>
          <strong>{author_name}</strong> <span>{created_at}</span>
          <a onClick={confirmDeleteComment} class="glyphicon glyphicon-remove" href="#"></a>
        </div>
        <pre>{body}</pre>
      </li>
    </ul>

    <div class="footer">
      <button class="btn btn-default btn-sm" onClick={openForm}>Post comment</button>
    </div>
  </virtual>

  <div class="panel panel-default" id="form-panel" if={editing}>
    <div class="panel-heading">Post comment <span onClick={closeForm} class="btn glyphicon glyphicon-remove pull-right" style="padding:0"></span></div>
    <form class="panel-body" onSubmit={postComment}>
      <label>name:</label> <input ref="author_name" class="form-control" placeholder="anonymous"/>
      <label>comment:</label>
      <textarea ref="body" class="form-control" rows="3"/>
      <button class="btn btn-primary" type="submit">Post</button>
    </form>
  </div>

  <script>
    const request = require('superagent')
    const moment = require('moment')

    comments_path() {
      return "/channels/" + this.channel.id + "/comments"
    }

    fetchComments() {
      request.get(this.comments_path(), (err, res) => {
        if (err) return false
        let comments = res.body.map( (comment) => {
          comment.author_name = comment.author_name || 'anonymous'
          comment.created_at = moment(comment.created_at).format('MM/DD HH:mm')
          return comment
        })
        this.update({comments})
        this.scrollToBottom()
      })
    }

    postComment(e) {
      e.preventDefault()
      let comment = {
        author_name: this.refs.author_name.value.trim(),
        body: this.refs.body.value.trim()
      }
      if (comment.body != '')
        this.closeForm()
        request.post(this.comments_path(), comment, (err, res) => {
          this.fetchComments()
        })
    }

    confirmDelete(e) {
      e.preventDefault()
      if (confirm('Are you sure to delete this channel ?'))
        request.delete(`/channels/${this.channel.id}`, (err, res) => { location.href = '/' } )
    }

    confirmDeleteComment(e) {
      e.preventDefault()
      request.delete(`/comments/${e.item.id}`, (err, res) => {
        let index = this.comments.findIndex( (comment) => comment.id == e.item.id )
        this.comments.splice(index, 1)
        this.update()
      })
    }

    openForm() { this.editing = true }
    closeForm() { this.editing = false }

    scrollToBottom() {
      let block = document.querySelector('ul.comments')
      block.scrollTop = block.scrollHeight
    }

    request.get(`/channels/${opts.slug}`, (err, res) => {
      if (err) return false
      this.update({channel: res.body})
      this.fetchComments()
    })

  </script>

  <style scoped>
    :scope {
    }
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

    h2.channel_name .glyphicon-remove { font-size: 15px; display: none; }
    h2.channel_name:hover .glyphicon-remove { display: inline ; }

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
