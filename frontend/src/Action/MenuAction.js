import RiotControl from 'riotcontrol'

class MenuAction {
  resetMenu() {
    RiotControl.trigger('RESET_MENU')
  }
  changePage(slug) {
    RiotControl.trigger('CHANGE_PAGE', slug)
  }
}

export default new MenuAction()
