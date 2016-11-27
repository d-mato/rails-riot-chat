<comment-form>
  <button class="btn btn-default btn-sm" onclick={openForm} show={!editing}>Post comment</button>

  <div class="panel panel-default" id="form-panel" if={editing}>
    <div class="panel-heading">Post comment <span onclick={closeForm} class="btn glyphicon glyphicon-remove pull-right" style="padding:0"></span></div>
    <form class="panel-body" onSubmit={postComment}>
      <label>name:</label> <input ref="author_name" class="form-control" placeholder="anonymous"/>
      <label>comment:</label>
      <textarea ref="body" class="form-control" rows="3"/>
      <button class="btn btn-primary" type="submit" ref="submit_btn">Post</button>
    </form>
  </div>

  <style scoped>
    :scope {
      position: fixed;
      bottom: 10px;
      width: 500px;
    }
  </style>


  import RiotControl from 'riotcontrol'
  import CommentAction from './Action/CommentAction'
  const commentAction = new CommentAction({channel_id: this.opts.channel_id})

  openForm() { this.editing = true }
  closeForm() { this.editing = false }

  postComment(e) {
    e.preventDefault()
    let comment = {
      author_name: this.refs.author_name.value.trim(),
      body: this.refs.body.value.trim()
    }
    this.refs.submit_btn.disabled = true
    commentAction.postComment(comment)
  }

  this.on('mount', () => {
    RiotControl.on('POSTED_COMMENT', () => {
      this.closeForm()
    })
    RiotControl.on('FAILED_POST_COMMENT', (err) => {
      this.refs.submit_btn.disabled = false
      console.log(err)
    })
  })
  this.on('unmount', () => {
    RiotControl.off('POSTED_COMMENT')
    RiotControl.off('FAILED_POST_COMMENT')
  })
</comment-form>
