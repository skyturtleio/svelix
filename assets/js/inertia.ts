/*
 * --------------------------------------------------------------------
 * Intitialize client-side Inertia app
 * --------------------------------------------------------------------
 *
 * `axios` is used for CSRF protection. More information can be found
 * in the Inertia.js Phoenix Adapter README.
 *
 * [Setting up the client-side](https://hexdocs.pm/inertia/readme.html#setting-up-the-client-side)
 *
 */

import axios from "axios";
import { createInertiaApp } from "@inertiajs/svelte";
import { mount } from 'svelte';
import Layout from "./layouts/Layout.svelte";

axios.defaults.xsrfHeaderName = "x-csrf-token";

createInertiaApp({
  resolve: async (name) => {
    const page = await import(`./pages/${name}.svelte`);
    return { default: page.default, layout: page.layout || Layout }
  },
  setup({ App, el, props }) {
    mount(App, { target: el!, props })
  },
});
