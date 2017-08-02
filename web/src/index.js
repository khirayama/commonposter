import axios from 'axios';

const AUTH_DOMAIN = process.env.AUTH_DOMAIN;
const AUTH_CLIENT_ID = process.env.AUTH_CLIENT_ID;
const API_SERVER_URL = 'http://localhost:3001';

function extractToken(hash = '') {
  const _hash = hash.replace('#', '');
  const token = {};
  _hash.split('&').forEach(str => {
    const kv = str.split('=');
    token[kv[0]] = kv[1];
  });
  return token;
}

window.addEventListener('DOMContentLoaded', () => {
  console.log(`Start app at ${new Date()}.`);

  if (!AUTH_DOMAIN || !AUTH_CLIENT_ID) {
    console.log('Please set AUTH_DOMAIN and AUTH_CLIENT_ID.');
    return;
  }

  const token = extractToken(window.location.hash);

  const loginBtn = document.querySelector('.btn-login');
  loginBtn.addEventListener('click', (event) => {
    event.preventDefault();
    const params = {
      client_id: AUTH_CLIENT_ID,
      redirect_uri: window.location.href,
      response_type: 'token id_token',
      scope: 'openid',
      nonce: 'nonce' + new Date().getTime(),
    };
    const queryString = Object.keys(params).map(key => key + '=' + window.encodeURIComponent(params[key])).join('&');
    const url = `https://${AUTH_DOMAIN}/authorize?${queryString}`;
    location.href = url;
  });

  const SendPublicAPIBtn = document.querySelector('.btn-send-public-api');
  SendPublicAPIBtn.addEventListener('click', (e) => {
    axios.get(`${API_SERVER_URL}/public`).then(({data}) => {
      console.log(data);
    });
  });
  const SendPrivateAPIBtn = document.querySelector('.btn-send-private-api');
  SendPrivateAPIBtn.addEventListener('click', (e) => {
    axios.get(`${API_SERVER_URL}/private`, {
      headers: {
        // Authorization: `Bearer ${token.access_token}`,
        Authorization: `Bearer ${token.id_token}`,
      },
    }).then(({data}) => {
      console.log(data);
    });
  });
});
