<script>
  let count = $state(0);
  let numbers = $state([1, 2, 3]);
  let total = $derived(numbers.reduce((sum, n) => sum + n, 0));

  function increment() {
    count = count + 1;
  }

  function addNumber() {
    numbers.push(numbers.length + 1);
  }
</script>

<h1 class="text-2xl bold mb-4">Reactivity</h1>

<h2 class="text-xl mb-4">Simple Counter</h2>
<button
  class="rounded-lg bg-zinc-900 hover:bg-zinc-700 py-2 px-3 text-sm font-semibold leading-6 text-white active:text-white/80"
  onclick={increment}
>
  Clicked {count} times
</button>

<h2 class="mt-4 text-xl mb-4">Deep Reactivity</h2>
<p class="mb-2">{numbers.join(" + ")} = {total}</p>
<button
  class="rounded-lg bg-blue-600 hover:bg-blue-700 py-2 px-3 text-sm font-semibold leading-6 text-white active:text-white/80"
  onclick={addNumber}
>
  Add a number
</button>
