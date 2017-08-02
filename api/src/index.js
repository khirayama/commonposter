const express = require('express');
const jwt = require('express-jwt');
const jwksRsa = require('jwks-rsa');

const AUTH_DOMAIN = process.env.AUTH_DOMAIN;
const AUTH_CLIENT_ID = process.env.AUTH_CLIENT_ID;

const app = express();

const checkJwt = jwt({
  secret: jwksRsa.expressJwtSecret({
    cache: true,
    rateLimit: true,
    jwksRequestsPerMinute: 5,
    jwksUri: `https://${AUTH_DOMAIN}/.well-known/jwks.json`
  }),
  // audience: 'http://localhost:3001',
  issuer: `https://${AUTH_DOMAIN}/`,
  algorithms: ['RS256']
});

app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', 'Authorization');
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
  next();
});

app.get('/public', (req, res) => {
  res.json({
    message: 'public api',
  });
});

app.get('/private', checkJwt, (req, res) => {
  // const authorization = req.headers.authorization;
  // const kv = authorization.split(' ');
  // const jwts = require('jwt-simple');
  // if (kv[0] === 'Bearer') {
  //   console.log(kv[1]);
  //   console.log(jwts.decode(kv[1], '', 'RS256'));
  // }
  res.json({
    message: 'private api',
  });
});

app.listen(3001);
