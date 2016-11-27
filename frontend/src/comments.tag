<comments>
  <div class="alert alert-warning" show={opts.items && !opts.items.length}>No comments!</div>
  <ul class="comments list-unstyled">
    <li each={opts.items} ref="comment_{id}">
      <div>
        <strong>{author_name}</strong> <span>{created_at}</span>
        <a onclick={deleteComment} class="glyphicon glyphicon-remove" href="#"></a>
      </div>
      <pre>{body}</pre>
    </li>
  </ul>

  <style scoped>
    ul.comments {
      overflow-y: scroll;
      max-height: 80vh;
      padding: 20px;
      margin-right: -15px;
    }
    li .glyphicon-remove { display: none; }
    li:hover .glyphicon-remove { display: inline; }
  </style>

  import CommentAction from './Action/CommentAction'
  const commentAction = new CommentAction({channel_id: this.opts.channel_id})

  deleteComment(e) {
    e.preventDefault()
    this.refs[`comment_${e.item.id}`].classList.add('fade-out')
    setTimeout(() => {
      commentAction.deleteComment(e.item.id)
    }, 1000)
  }

  scrollToBottom() {
    let block = document.querySelector('ul.comments')
    block.scrollTop = block.scrollHeight
  }
</comments>
