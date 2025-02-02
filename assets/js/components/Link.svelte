<script>
  import { inertia } from "@inertiajs/svelte";

  let { to, children } = $props();
</script>

<a use:inertia href={to}>{@render children()}</a>
