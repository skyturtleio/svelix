<script lang="ts">
  let todos = $state([
    { title: "get groceries", id: "20394u2039423094234", isDone: false },
    { title: "fly to hawaii", id: "0960970984059609800", isDone: false },
    { title: "feed baby strawberries", id: "029384029380293", isDone: true },
  ]);
</script>

<h1 class="text-2xl font-semibold">Todos</h1>

<div class="grid gap-4 my-4">
  {#each todos as todo (todo.id)}
    <div class="todo border-dashed checked:line-through">
      <input value={todo.isDone} type="checkbox" bind:checked={todo.isDone} />
      <input
        value={todo.title}
        type="text"
        class="border-none {todo.isDone ? 'line-through' : ''}"
      />
    </div>
  {/each}
</div>
