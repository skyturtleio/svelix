<script>
  import Layout from "../layouts/Layout.svelte";
  let { message, name } = $props();
</script>

<Layout>
  <h1 class="pb-4 text-2xl font-semibold underline">{message}</h1>
  <p>Hello there {name}!</p>
</Layout>
