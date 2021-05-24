/* eslint-disable no-console */
export const state = () => ({
  user: {},
  isAuthenticate: false,
  accessToken: null,
});

export const mutations = {
  SET_USER(state, user) {
    state.user = user;
    state.isAuthenticate = true;
  },
  SET_TOKEN(state, token) {
    state.accessToken = token;
  },
};

export const actions = {
  nuxtServerInit({ commit }, { req }) {
    if (req.session.user && req.session.tokens) {
      const expire = new Date(req.session.tokens.expire);

      if (expire - Date.now() < 86400000) {
        // if the token expires in less than a day then refresh token

        fetch("/api/refresh", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
        });
      }

      commit("SET_USER", req.session.user);
      commit("SET_TOKEN", req.session.tokens.access_token);

      this.$axios.setHeader(
        "Authorization",
        "Bearer " + `${req.session.tokens.access_token}`
      );
    }
  },
};
