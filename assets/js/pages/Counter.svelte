<script>
  let count = $state(0);

  function increment() {
    count = count + 1;
  }
</script>

<h1 class="text-2xl semibold mb-4">Counter</h1>
<button
  class="rounded-lg bg-zinc-900 hover:bg-zinc-700 py-2 px-3 text-sm font-semibold leading-6 text-white active:text-white/80"
  onclick={increment}
>
  Clicked {count} times
</button>
