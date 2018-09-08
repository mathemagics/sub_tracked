import axios from 'axios';

import { saveToLocalStorage, getFromLocalStorage } from 'service/storage';

const REDIRECT_URI = 'http://localhost:8080';

const API_URL = 'http://localhost:4000/api';

const OAUTH_HOSTS = {
  google: {
    urlRoot: 'https://accounts.google.com/o/oauth2/v2/auth',
    clientId: '588073605043-058jdnif2i46g741bhafi0g4uj9vqv90.apps.googleusercontent.com',
  },
};

// creates a sufficiently random string of characters to be used as the state key
// on the request to the oauth provider to prevent xss.
export const generateHash = () => {
  const crypto = window.crypto || window.msCrypto;
  const validChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

  let array = new Uint8Array(40);
  crypto.getRandomValues(array);
  array = array.map(x => validChars.charCodeAt(x % validChars.length));
  return String.fromCharCode.apply(null, array);
};

export const oauthURL = ({ provider, state }) => {
  const { urlRoot, clientId } = OAUTH_HOSTS[provider];
  return `${urlRoot}?client_id=${clientId}&redirect_uri=${REDIRECT_URI}&response_type=token&scope=email&include_granted_scopes=true&state=${state}`;
};

export const parseOauthParams = (paramString) => {
  const stateRegexResponse = /#state=(.*?)&/.exec(paramString);
  const state = stateRegexResponse ? stateRegexResponse[1] : null;
  const accessCodeRegexResponse = /access_token=(.*?)&/.exec(paramString);
  const accessCode = accessCodeRegexResponse ? accessCodeRegexResponse[1] : null;
  return { state, accessCode };
};


const verifyOauthState = (state) => {
  const oauthHash = getFromLocalStorage('oauthHash');
  console.log('state: ', state, ', hash: ', oauthHash);
  return state && state === oauthHash;
};

const attemptOauthSignin = (accessCode) => {
  console.log(accessCode);
  axios.post(`${API_URL}/auth/callback`);
};

export const AuthenticateWithOauth = (paramString) => {
  const { state, accessCode } = parseOauthParams(paramString);
  if (verifyOauthState(state)) {
    attemptOauthSignin(accessCode);
  }
};
