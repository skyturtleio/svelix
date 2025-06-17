import { createInertiaApp } from "@inertiajs/svelte";
import createServer from "@inertiajs/svelte/server";
import { render as svelteRender } from "svelte/server";
import Layout from "./layouts/Layout.svelte";

export function render(page) {
  return createInertiaApp({
    page,
    resolve: async (name) => {
      const page = await import(`./pages/${name}.svelte`);
      return { default: page.default, layout: page.layout || Layout };
    },
    setup({ App, props }) {
      return svelteRender(App, { props });
    },
  });
}
