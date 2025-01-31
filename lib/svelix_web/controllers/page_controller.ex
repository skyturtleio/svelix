defmodule SvelixWeb.PageController do
  use SvelixWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    conn =
      conn
      |> assign(:page_title, "Home")

    render(conn, :home, layout: false)
  end

  def message(conn, _params) do
    conn =
      conn
      |> assign(:page_title, "Svelte Component")
      |> assign_prop(:message, "Hello from Svelte and Inertia!")
      |> assign_prop(:name, "Turtle")

    render_inertia(conn, "Message")
  end
end
