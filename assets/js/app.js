/*
 * --------------------------------------------------------------------
 * Phoenix Channels
 * --------------------------------------------------------------------
 *
 * If you want to use Phoenix channels, run `mix help phx.gen.channel`
 * to get started and then uncomment the line below.
 */
// import "./user_socket.js"

/*
 * --------------------------------------------------------------------
 * Installing NPM packages
 * --------------------------------------------------------------------
 *
 * You can include dependencies in two ways.
 *
 * The simplest option is to put them in assets/vendor and
 * import them using relative paths:
 *
 *     import "../vendor/some-package.js"
 *
 * Since we might do more with NPM packages (e.g. TypeScript, Zero Sync)
 * we will use the alternate method of
 * `npm install some-package --prefix assets` and import them like in
 * a traditional front end app
 *
 *    import "some-package"
 */

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
// This is part of the stock Phoenix `app.js`
import "phoenix_html";
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";
import topbar from "topbar";

/*
 * --------------------------------------------------------------------
 * Intitialize client-side Inertia app
 * --------------------------------------------------------------------
 *
 * `axios` is used for CSRF protection. More information can be found
 * in the Inertia.js Phoenix Adapter README.
 *
 * [Setting up the client-side](https://hexdocs.pm/inertia/readme.html#setting-up-the-client-side)
 */

import axios from "axios";
import { createInertiaApp } from "@inertiajs/svelte";
import { hydrate, mount } from "svelte";
import Layout from "./layouts/Layout.svelte";

axios.defaults.xsrfHeaderName = "x-csrf-token";

createInertiaApp({
  resolve: async (name) => {
    const page = await import(`./pages/${name}.svelte`);
    return { default: page.default, layout: page.layout || Layout };
  },
  setup({ App, el, props }) {
    if (el.dataset.serverRendered === "true") {
      console.log("hydrating the app");
      hydrate(App, { target: el, props });
    } else {
      console.log("mounting the app (no SSR)");
      mount(App, { target: el, props });
    }
  },
});

/*
 * --------------------------------------------------------------------
 * Default Phoenix `app.js`
 * --------------------------------------------------------------------
 *
 * The code below is included in a "stock" Phoenix application.
 */
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute(
  "content",
);
let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: { _csrf_token: csrfToken },
});

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" });
window.addEventListener("phx:page-loading-start", (_info) => topbar.show(300));
window.addEventListener("phx:page-loading-stop", (_info) => topbar.hide());

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;
