defmodule SvelixWeb.PageControllerTest do
  use SvelixWeb.ConnCase

  test "renders the home page (Welcome component)", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert inertia_component(conn) == "Welcome"

    assert %{
             message: "Phoenix and Inertia and Svelte 🔥",
             name: "Turtle"
           } = inertia_props(conn)

    assert html_response(conn, 200) =~ "</html>"
  end

  test "renders the Counter Svelte component", %{conn: conn} do
    conn = get(conn, ~p"/counter")
    assert inertia_component(conn) == "Counter"
  end
end
