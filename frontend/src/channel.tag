<channel>
  <div show={loading} class="loading-filter">
    <div class="alert alert-info"><span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span> Loading ...</div>
  </div>

  <div class="alert alert-danger" show={error}>Cannot find channel !</div>

  <virtual if={channel}>
    <div class="row channel-header">
      <h2 class="channel_name col-xs-8">
        Channel:
        <virtual show={!editing_channnel_name}>
          <span class="" onclick={editChannelName}>{channel.name}</span>
          <a onclick={confirmDelete} show={channel.deletable} class="glyphicon glyphicon-remove" href="#"></a>
        </virtual>

        <input value={channel.name} show={editing_channnel_name} onchange={updateChannelName} onblur={updateChannelName}/>
      </h2>

      <div class="col-xs-4 channel-stats">
        <ul class="list-unstyled">
          <li><small>Created: {channel.created_at}</small></li>
          <li><small if={comments}>Total comments: {comments.length}</small></li>
        </ul>
      </div>
    </div>

    <comments items={comments} channel_id={channel.id}></comments>
    <comment-form channel_id={channel.id}></comment-form>

  </virtual>

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
    .channel-header {
    }
    h2.channel_name {
      cursor: pointer;
      font-size: 2.2rem;
    }
    h2.channel_name .glyphicon-remove { font-size: 15px; display: none; }
    h2.channel_name:hover .glyphicon-remove { display: inline; }
    .channel-stats ul { margin: 10px 0 0 0; }
  </style>

  import RiotControl from 'riotcontrol'
  import AuthStore from './Store/AuthStore'
  import ChannelsStore from './Store/ChannelsStore'
  import CommentStore from './Store/CommentStore'
  import CommentAction from './Action/CommentAction'
  import MenuAction from './Action/MenuAction'

  const commentAction = new CommentAction()
  const menuAction = new MenuAction()

  confirmDelete(e) {
    e.preventDefault()
    if (confirm('Are you sure to delete this channel ?'))
      ChannelsStore.deleteChannel(this.channel.id)
  }

  editChannelName(e) {
    if (this.channel.editable ) this.editing_channnel_name = true
  }

  updateChannelName(e) {
    this.editing_channnel_name = false
    if (this.channel.name == e.target.value) return false
    ChannelsStore.updateChannel(this.channel.id, {name: e.target.value})
  }

  this.on('mount', () => {
    this.loading = true
    ChannelsStore.fetchChannel(opts.slug)

    RiotControl.on('FAIL_FETCH_CHANNEL', () => {
      this.update({error: true, loading: false})
    })

    RiotControl.on('FETCHED_CHANNEL', (channel) => {
      this.update({channel})
      commentAction.channel_id = this.channel.id
      commentAction.reloadComments()
    })

    RiotControl.on('UPDATED_CHANNEL', (channel) => {
      this.update({channel})
      menuAction.reloadMenu()
    })
    RiotControl.on('DELETED_CHANNEL', () => {
      location.href = '/#/'
      menuAction.reloadMenu()
    })

    RiotControl.on('RELOADED_COMMENTS', () => {
      this.update({comments: CommentStore.getComments(), loading: false})
      this.tags.comments.scrollToBottom()
    })

    RiotControl.on('DELETED_COMMENT', () => {
      this.update({comments: CommentStore.getComments()})
    })
  })

  this.on('unmount', () => {
    RiotControl.off('FAIL_FETCH_CHANNEL')
    RiotControl.off('FETCHED_CHANNEL')
    RiotControl.off('UPDATED_CHANNEL')
    RiotControl.off('DELETED_CHANNEL')
    RiotControl.off('RELOADED_COMMENTS')
    RiotControl.off('FAILED_POST_COMMENT')
    RiotControl.off('DELETED_COMMENT')
  })
</channel>
