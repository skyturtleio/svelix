defmodule SvelixWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use SvelixWeb, :controller` and
  `use SvelixWeb, :live_view`.
  """
  use SvelixWeb, :html

  @env Mix.env()
  embed_templates "layouts/*"

  def dev_env? do
    @env == :dev
  end
end
