import RiotControl from 'riotcontrol'

export default class MenuAction {
  reloadMenu() {
    RiotControl.trigger('RELOAD_MENU')
  }
  changePage(slug) {
    RiotControl.trigger('CHANGE_PAGE', slug)
  }
}
