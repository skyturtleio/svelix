<script>
  import Link from "../components/Link.svelte";

  let { children } = $props();
</script>

<main>
  <header class="pb-4">
    <Link href="/inertia" prefetch={["hover", "hover"]}>Home</Link>
    <Link href="/inertia/counter" prefetch={["mount", "hover"]}>Counter</Link>
    <Link href="/stock" phxLink>Stock</Link>
  </header>
  <div>
    {@render children()}
  </div>
</main>
