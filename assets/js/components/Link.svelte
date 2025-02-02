<script>
  import { inertia } from "@inertiajs/svelte";

  let { href, children } = $props();
</script>

<a use:inertia {href} class="underline pr-4">{@render children()}</a>
