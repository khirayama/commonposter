const express = require('express');

const app = express();

function template() {
  return `
    <html>
      <head>
        <script src="/bundle.js"></script>
      </head>
      <body>
        <section class="container">
          <h1>Auth0 app</h1>
          <div class="btn-login">Login</div>
          <div class="btn-send-public-api">Public API</div>
          <div class="btn-send-private-api">Private API</div>
        </section>
      </body>
    </html>
  `;
}

app.use('/', express.static('./dist'));

app.get('/', (req, res) => {
  res.send(template());
});

app.listen(3000);
