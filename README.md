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

## Client-side Setup

- Install the Inertia.js library for your frontend library as well as the frontend library itself. Remember, everything "frontend" related will be done in the `assets` directory. Also, because Svelte will be processed through an esbuild plugin, we will install those required dependencies and also remove the esbuild hex package from the Elixir deps.

Note that we are using `--prefix assets` so that these commands can be run from the project's root directory.

Install the esbuild and the esbuild-svelte plugin:

```shell
npm --prefix assets install -D esbuild esbuild-svelte
```
Install the inertiajs client-side library and other libraries already included in stock Phoenix app.

```shell
npm --prefix assets install \
@inertiajs/svelte topbar axios \
./deps/phoenix ./deps/phoenix_html ./deps/phoenix_live_view 
```

- Initialize the client-side library in `app.js`.
- Add `ssr.js`
- Remove ESBuild (to prepare to use custom `build.js`)

Delete `config :esbuild` from `config.exs`
Remove `esbuild` dependency in `mix.exs`
Unlock `esbuild` dependency
`mix deps.unlock esbuild`
Add custom `esbuild` script, `build.js`
Replace esbuild watchers to use custom `build.js` script

- Add a page component in `assets/js/pages/` to render -> otherwise you're going to get an error like `unable to import **/*/pages/blah.svelte`. I was getting this error

```shell
[WARNING] The glob pattern import("./pages/**/*.svelte") did not match any files [empty-glob]

    js/app.js:62:24:
      62 │     return await import(`./pages/${name}.svelte`);
         ╵                         ~~~~~~~~~~~~~~~~~~~~~~~~
```
Update aliases in `mix.exs`
Add `priv/ssr.js` to gitignore
Add Inertia.SSR to supervision tree in `application.ex`
Add SSR to Inertia `:config` -> enable true

