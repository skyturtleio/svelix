<script>
  let { message, name } = $props();
</script>

<svelte:head>
  <title>Welcome</title>
</svelte:head>
<h1 class="pb-4 text-2xl font-semibold underline">{message}</h1>
<p>Hello there {name}!</p>
