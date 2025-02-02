<script>
  import Layout from "../layouts/Layout.svelte";
  let count = $state(0);

  function increment() {
    count = count + 1;
  }
</script>

<Layout>
  <h1>Counter</h1>
  <button class="border" onclick={increment}>
    Clicked {count} times
  </button>
</Layout>
