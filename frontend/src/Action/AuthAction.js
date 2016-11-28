import RiotControl from 'riotcontrol'

export default class AuthAction {
  sign_in(user) {
    RiotControl.trigger('USER_SIGN_IN', user)
  }
}
