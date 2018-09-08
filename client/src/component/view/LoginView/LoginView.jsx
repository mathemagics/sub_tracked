import React, { Component } from 'react';

import { oauthURL, generateHash } from 'service/auth';
import { saveToLocalStorage } from 'service/storage';

class LoginView extends Component {
  state = {
    oauthHash: null,
  }

  componentDidMount = () => {
    const oauthHash = generateHash();
    saveToLocalStorage({ key: 'oauthHash', value: oauthHash });
    this.setState({ oauthHash });
  }

  render() {
    const { oauthHash } = this.state;
    return (
      <a href={oauthURL({ provider: 'google', state: oauthHash })}>
        Log in with google
      </a>
    );
  }
}

export { LoginView };
