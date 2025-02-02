<script>
  import Link from "../components/Link.svelte";

  let { children } = $props();
</script>

<main>
  <header class="pb-4">
    <Link href="/">Home</Link>
    <Link href="/counter">Counter</Link>
    <Link href="/stock" phxLink>Stock</Link>
  </header>
  <div>
    {@render children()}
  </div>
</main>
