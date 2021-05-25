import https from "https";
export default ({ $config: { baseURL }, $axios, store }) => {
  $axios.defaults.baseURL = baseURL;
  $axios.defaults.httpsAgent = new https.Agent({ rejectUnauthorized: false });
};
