defmodule PhoenixGon.Utils do
  @moduledoc """
  Usefull methods for elixir modules
  """
  require Logger 
  @doc """
  Return if mix env dev
  """
  @spec mix_env_dev?(Plug.Conn.t()) :: Boolean.t()
  def mix_env_dev?(conn), do: variables(conn).env == :dev

  @doc """
  Return if mix env prod
  """
  @spec mix_env_prod?(Plug.Conn.t()) :: Booleant.t()
  def mix_env_prod?(conn), do: variables(conn).env == :prod

  @doc """
  Return elixir gon struct.
  """
  @spec variables(Plug.Conn.t()) :: %PhoenixGon.Storage{}
  def variables(conn), do: conn.private[:phoenix_gon]

  @doc """
  Returns elixir assets.
  """
  @spec assets(Plug.Conn.t()) :: Map.t()
  def assets(conn) do
    case variables(conn) do
      %{assets: assets} ->
        assets
        other ->
        Logger.warn("Gon assets is not a struct, but #{inspect(other)}")
        []
      end
    end

  @doc """
  Returns all elixir settings.
  """
  @spec settings(Plug.Conn.t()) :: List.t()
  def settings(conn) do
    case variables(conn) do
      struct when is_struct(struct) ->
        
    Enum.filter(Map.from_struct(struct), fn {key, _} ->
      key != :assets
    end)

    other ->
      Logger.warn("Gon settings is not a struct, but #{inspect(other)}")
      []
    end
  end

  @doc false
  @spec settings(Plug.Conn.t(), Atom.t()) :: any()
  def settings(conn, key), do: settings(conn)[key]

  @doc """
  Return current gon namespace.
  """
  @spec namespace(Plug.Conn.t()) :: String.t()
  def namespace(conn) do
    name = settings(conn, :namespace)

    if not is_nil(name) do
      String.split(to_string(name), ".") |> List.last()
    end || "Gon"
  end
end
