// eslint-disable-next-line nuxt/no-cjs-in-config
const session = require("express-session");
const redisClient = require("redis").createClient();
const redisStore = require("connect-redis")(session);

export default {
  // Global page headers: https://go.nuxtjs.dev/config-head
  head: {
    title: "PMS",
    meta: [
      { charset: "utf-8" },
      { name: "viewport", content: "width=device-width, initial-scale=1" },
      { hid: "description", name: "description", content: "" },
    ],
    link: [{ rel: "icon", type: "image/x-icon", href: "/favicon.ico" }],
  },

  // Global CSS: https://go.nuxtjs.dev/config-css
  css: ["vuesax/dist/vuesax.css", "~/assets/css/main.css"],

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
    // https://go.nuxtjs.dev/eslint
    "@nuxtjs/eslint-module",
  ],

  serverMiddleware: [
    session({
      secret:
        process.env.SESSION_SECRET || "ThisIsHowYouUseRedisSessionStorage",
      name: "__session_id",
      resave: false,
      saveUninitialized: true,
      // eslint-disable-next-line new-cap
      store: new redisStore({
        host: "localhost",
        port: 6379,
        client: redisClient,
        ttl: 86400,
      }),
    }),
    { path: "/api", handler: "~/api/index.js" },
  ],

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: ["@/plugins/vuesax", "@/plugins/axios.js"],

  publicRuntimeConfig: {
    baseURL: process.env.API_BASE_URL || "http://127.0.0.1:8000/",
  },

  privateRuntimeConfig: {
    apiSecret: process.env.API_SECRET,
    sessionSecret:
      process.env.SESSION_SECRET || "ThisIsHowYouUseRedisSessionStorage",
  },

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: ["@nuxtjs/axios", "@nuxtjs/pwa"],

  // Axios module configuration: https://go.nuxtjs.dev/config-axios
  axios: {},

  // PWA module configuration: https://go.nuxtjs.dev/pwa
  pwa: {
    manifest: {
      lang: "en",
    },
  },

  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {},
};
