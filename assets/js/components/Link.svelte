<script>
  import { inertia } from "@inertiajs/svelte";

  let { href, phxLink = false, children } = $props();
</script>

{#if phxLink}
  <a {href} class="underline pr-4">{@render children()}</a>
{:else}
  <a use:inertia {href} class="underline pr-4">{@render children()}</a>
{/if}
