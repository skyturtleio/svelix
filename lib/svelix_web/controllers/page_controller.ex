defmodule SvelixWeb.PageController do
  use SvelixWeb, :controller

  def welcome(conn, _params) do
    conn =
      conn
      |> assign(:page_title, "Welcome")
      |> assign_prop(:message, "Phoenix and Inertia and Svelte 🔥")
      |> assign_prop(:name, "Turtle")

    render_inertia(conn, "Welcome")
  end

  def stock(conn, _params) do
    # Home page for a stock Phoenix app.
    # The home page is often custom made,
    # so skip the default app layout.
    conn =
      conn
      |> assign(:page_title, "Stock Phoenix App")

    render(conn, :home, layout: false)
  end
end
