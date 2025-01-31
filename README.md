# Svelix

An example repo for a modern monolith using Phoenix, Inertia.js, and Svelte. Because Svelte requires an esbuild plugin, you need to have Node installed.

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


## Server-side Setup

- Add the `:inertia` package to your deps in `mix.exs` and run `mix deps.get`

```elixir
  {:inertia, "~> 2.1.0"}
```

- Add Inertia configuration to `confix.exs`
- Add Inertia helpers for Controller and HTML to `SvelixWeb`
- Add `Inertia.Plug` to your browser pipeline in your `router.ex`
- Update `<head>` component in the root layout so the client-side library will keep the title in sync
