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
      commit("SET_USER", req.session.user);
      commit("SET_TOKEN", req.session.tokens.access_token);

      this.$axios.setHeader(
        "Authorization",
        "Bearer " + `${req.session.tokens.access_token}`
      );
    }
  },
};
