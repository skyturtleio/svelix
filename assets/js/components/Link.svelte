<script>
  import { inertia } from "@inertiajs/svelte";

  let { href, phxLink = false, prefetch, children } = $props();
</script>

{#if phxLink}
  <a {href} class="underline pr-4">{@render children()}</a>
{:else}
  <a use:inertia={{ prefetch: prefetch }} {href} class="underline pr-4"
    >{@render children()}</a
  >
{/if}
