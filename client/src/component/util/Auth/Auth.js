import { Component } from 'react';

import { AuthenticateWithOauth } from 'service/auth';

class Auth extends Component {
  componentDidMount = () => {
    const oauthResponse = AuthenticateWithOauth(this.props.location.hash);
  }

  render() {
    return this.props.children;
  }
}

export { Auth };
