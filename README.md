# Svelix

An example repo for a modern monolith using Phoenix, Inertia.js, and Svelte 5. 
You can find the application running at https://svelix.skyturtle.io/

It is deployed to a self-hosted VPS using [Coolify](https://www.coolify.io/). A healthcheck has been enabled using a custom plug module, `SvelixWeb.Healthcheck`.

On the home page you will see a basic navbar with three links: `Home`, `Counter`, and `Stock`. `Home` and `Counter` are Svelte components and can be found within the `assets` directory. The `Home` page receives props (text in the `h1` tag and the name `Turtle`) from a standard Phoenix controller. The navigation for the links between these pages uses Inertia with the `use:inertia` Svelte directive. `Stock` is the default home page that ships with `mix phx.new my_app`.

## Development 

Svelte requires an esbuild plugin so you need to have Node.js installed. This application was built using Node.js v22.13.1. Aside from that, it will have the same requirements as any other Phoenix app e.g., Postgres, Elixir, etc.

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser. The home page is a Svelte component being rendered by Inertia.

## Inertia.js Setup

The official setup instructions can be found on HexDocs for the [Inertia.js Phoenix Adapter](https://hexdocs.pm/inertia/readme.html#installation). These setup instructions give a high-level overview of the steps. The details below are to help out my future self and also clariy some questions I had as I was going through the instructions. The server-side setup follows the official instructions closely. The client-side setup is fairly different because the Phoenix adapter docs use React.

### Server-side Setup

- Add the `:inertia` package to your deps in `mix.exs` and run `mix deps.get`

```elixir
  {:inertia, "~> 2.1.0"}
```

- Add Inertia configuration to `confix.exs`
- Add Inertia helpers for Controller and HTML to `SvelixWeb`
- Add `Inertia.Plug` to your browser pipeline in your `router.ex`
- Update `<head>` component in the root layout so the client-side library will keep the title in sync

### Client-side Setup

**NOTE: SSR IS NOT WORKING YET EVEN THOUGH THE CODE IS IN `build.js`**

Install the Inertia.js library for your frontend library as well as the frontend library itself. Remember, everything "frontend" related will be done in the `assets` directory. Also, because Svelte will be processed through an esbuild plugin, we will install those required dependencies and also remove the esbuild hex package from the Elixir deps.

We are using `--prefix assets` so that these commands can be run from the project's root directory.

- Install the esbuild and the esbuild-svelte plugin:

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
- Delete `config :esbuild` from `config.exs`
- Remove `esbuild` dependency in `mix.exs`
- Unlock `esbuild` dependency
- `mix deps.unlock esbuild`
- Add custom `esbuild` script, `build.js`
- Replace esbuild watchers to use custom `build.js` script
- Add a page component in `assets/js/pages/` to render. Otherwise you're going to get an error like:

```shell
[WARNING] The glob pattern import("./pages/**/*.svelte") did not match any files [empty-glob]

    js/app.js:62:24:
      62 │     return await import(`./pages/${name}.svelte`);
         ╵                         ~~~~~~~~~~~~~~~~~~~~~~~~
```

- Update aliases in `mix.exs`
- Add `priv/ssr.js` to gitignore
- Add Inertia.SSR to supervision tree in `application.ex`
- Add SSR to Inertia `:config` -> enable true

## Deploying to Coolify

TODO: Explain building release, adding Node.js to Dockerfile that is created when building a release, some pain points: forgot to add Node.js to builder, ran `npm install --omit=dev` (which causes `mix assets.deploy` to fail because `esbuild` is a dev dependency), Ecto migrations (had to change the last command in Dockerfile to run migations before starting the app)

- Add health checks. This article explains how to set up a Plug for health checks: [Health checks for Plug and Phoenix](https://jola.dev/posts/health-checks-for-plug-and-phoenix).

For Coolify, under Healthcheck, check the box for "Enabled". For the settings:

Method GET, Scheme http, Host localhost, Port leave blank (placeholder is 80), Path `/health-check` (which is the route set up in `SvelixWeb.Healthcheck`)

