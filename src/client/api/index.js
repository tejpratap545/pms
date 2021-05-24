const express = require("express");
const session = require("express-session");
const redis = require("redis");
const redisClient = redis.createClient();
const redisStore = require("connect-redis")(session);
const bodyParser = require("body-parser");

const app = express();
app.use(bodyParser.json());
redisClient.on("error", (err) => {
  // eslint-disable-next-line no-console
  console.log("Redis error: ", err);
});

app.use(
  session({
    secret: process.env.SESSION_SECRET || "ThisIsHowYouUseRedisSessionStorage",
    name: "__session_id",
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false }, // Note that the cookie-parser module is no longer needed
    // eslint-disable-next-line new-cap
    store: new redisStore({
      host: "localhost",
      port: 6379,
      client: redisClient,
      ttl: 86400,
    }),
  })
);

const auth = require("./auth");
app.use(auth);

module.exports = app;
