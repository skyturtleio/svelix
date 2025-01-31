import { createInertiaApp } from "@inertiajs/svelte";
import createServer from '@inertiajs/svelte/server'
import { render as svelteRender } from 'svelte/server'

export function render(page) {
  return createInertiaApp({
    page,
    resolve: async (name) => await import(`./pages/${name}.svelte`),
    setup({ App, props }) {
      return svelteRender(App, { props })
    },
  });
}
