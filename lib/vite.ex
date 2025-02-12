defmodule Vite do
  @moduledoc false

  # Provide "constants" as functions so that inner modules can refer to them.
  def manifest_file, do: "priv/static/assets/vite_manifest.json"
  def cache_key, do: {:vite, "vite_manifest"}
  def default_env, do: :dev
  def endpoint, do: SvelixWeb.Endpoint

  defmodule PhxManifestReader do
    @moduledoc """
    Reads Vite manifest data either from a built digest (for prod) or directly from disk (for non-prod).
    """
    require Logger
    alias Vite

    @spec read() :: map()
    def read do
      case :persistent_term.get(Vite.cache_key(), nil) do
        nil ->
          manifest = do_read(current_env())
          :persistent_term.put(Vite.cache_key(), manifest)
          manifest

        manifest ->
          manifest
      end
    end

    @spec current_env() :: atom()
    def current_env do
      Application.get_env(:svelix, :env, Vite.default_env())
    end

    @spec do_read(atom()) :: map()
    defp do_read(:prod), do: read_prod_manifest()
    defp do_read(_env), do: read_file_manifest(Vite.manifest_file())

    # Reads the manifest file from the built static digest in production.
    @spec read_prod_manifest() :: map()
    defp read_prod_manifest do
      # In production the manifest location is picked up from the parent's manifest_file/0.

      {otp_app, relative_path} = {Vite.endpoint().config(:otp_app), Vite.manifest_file()}

      manifest_path = Application.app_dir(otp_app, relative_path)

      with true <- File.exists?(manifest_path),
           {:ok, content} <- File.read(manifest_path),
           {:ok, decoded} <- Phoenix.json_library().decode(content) do
        decoded
      else
        _ ->
          Logger.error(
            "Could not find static manifest at #{inspect(manifest_path)}. " <>
              "Run \"mix phx.digest\" after building your static files " <>
              "or remove the configuration from \"config/prod.exs\"."
          )

          %{}
      end
    end

    # Reads the manifest from a file for non-production environments.
    @spec read_file_manifest(String.t()) :: map()
    defp read_file_manifest(path) do
      path
      |> File.read!()
      |> Jason.decode!()
    end
  end

  defmodule Manifest do
    @moduledoc """
    Retrieves Vite's generated file references.
    """
    alias Vite.PhxManifestReader

    @main_js_file "js/app.js"
    @inertia_js_file "js/inertia.tsx"

    @spec read() :: map()
    def read, do: PhxManifestReader.read()

    @doc "Returns the main JavaScript file path prepended with a slash."
    @spec main_js() :: String.t()
    def main_js, do: get_file(@main_js_file)

    @doc "Returns the inertia JavaScript file path prepended with a slash."
    @spec inertia_js() :: String.t()
    def inertia_js, do: get_file(@inertia_js_file)

    @doc "Returns the main CSS file path prepended with a slash, if available."
    @spec main_css() :: String.t()
    def main_css, do: get_css(@main_js_file)

    @spec get_file(String.t()) :: String.t()
    def get_file(file) do
      read()
      |> get_in([file, "file"])
      |> prepend_slash()
    end

    @spec get_css(String.t()) :: String.t()
    def get_css(file) do
      read()
      |> get_in([file, "css"])
      |> List.first()
      |> prepend_slash()
    end

    @doc """
    Returns the list of import paths for a given file,
    each path is prepended with a slash.
    """
    @spec get_imports(String.t()) :: [String.t()]
    def get_imports(file) do
      read()
      |> get_in([file, "imports"])
      |> case do
        nil -> []
        imports -> Enum.map(imports, &get_file/1)
      end
    end

    defp prepend_slash(nil), do: ""
    defp prepend_slash(path) when is_binary(path), do: "/" <> path
    defp prepend_slash(_), do: ""
  end
end
