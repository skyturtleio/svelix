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
end
