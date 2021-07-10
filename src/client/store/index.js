/* eslint-disable no-console */
export const state = () => ({
	user: {},
	isAuthenticate: false,
	accessToken: null
});

export const mutations = {
	SET_USER(state, user) {
		state.user = user;
		state.isAuthenticate = true;
	},
	SET_TOKEN(state, token) {
		state.accessToken = token;
	}
};

export const actions = {
	async nuxtServerInit({ commit }, { req }) {
		if (req.session.user && req.session.tokens) {
			const expire = new Date(req.session.tokens.expire);

			if (expire - Date.now() < 24 * 60 * 60 * 1000) {
				// if the token expires in less than a day then refresh token

				try {
					const response = await this.$axios.$post(`auth/token/`, {
						grant_type: 'refresh_token',
						refresh_token: req.session.tokens.refresh_token
					});
					const tokens = response.data;
					req.session.isAuthenticate = true;
					req.session.tokens = tokens;
				} catch (error) {
					req.session.destroy();
					return;
				}
			}
			try {
				const user = await this.$axios.get(`api/profile/me`, {
					headers: {
						Authorization: `Bearer ${req.session.tokens.access_token}`
					}
				});

				req.session.user = user.data;

				commit('SET_USER', req.session.user);
				commit('SET_TOKEN', req.session.tokens.access_token);

				this.$axios.setHeader('Authorization', 'Bearer ' + `${req.session.tokens.access_token}`);
			} catch (error) {
				console.log(error);
				req.session.destroy();
			}
		}
	}
};
