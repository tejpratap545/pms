export default function ({ store, redirect }) {
  if (!store.state.isAuthenticate) {
    return redirect("/login");
  }
}
