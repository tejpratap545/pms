const { Router } = require("express");
const axios = require("axios");
const router = Router();
const apiUrl = process.env.API_BASE_URL || "http://127.0.0.1:8000";

router.post("/login", async (req, res, next) => {
  try {
    const response = await axios.post(`${apiUrl}/auth/token/`, {
      username: req.body.username,
      password: req.body.password,
    });
    const tokens = response.data;
    req.session.isAuthenticate = true;
    req.session.tokens = tokens;

    const user = await axios.get(`${apiUrl}/api/profile/me`, {
      headers: {
        Authorization: `Bearer ${tokens.access_token}`,
      },
    });

    req.session.user = user.data;
    req.session.save();

    res.status(200);
  } catch (error) {
    res.status(400);
  }

  res.end();
});

router.post("/logout", (req, res, next) => {
  req.session.destroy();
  res.json(req.session);
});

router.post("/refresh", async (req, res, next) => {
  try {
    const response = await axios.post(`${apiUrl}/auth/token/`, {
      grant_type: "refresh_token",
      refresh_token: req.session.tokens.refresh_token,
    });
    const tokens = response.data;
    req.session.isAuthenticate = true;
    req.session.tokens = tokens;

    const user = await axios.get(`${apiUrl}/api/profile/me`, {
      headers: {
        Authorization: `Bearer ${tokens.access_token}`,
      },
    });

    req.session.user = user.data;
    req.session.save();

    res.status(200);
  } catch (error) {
    res.status(400);
  }

  res.end();
});

router.get("/user", (req, res, next) => {
  res.json(req.session.user);
});

router.get("/isAuthenticate", (req, res, next) => {
  res.json(req.session.isAuthenticate);
});
module.exports = router;
