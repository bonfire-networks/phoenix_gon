defmodule PhoenixGon.PipelineTest do
  use ExUnit.Case, async: false

  import PhoenixGon.TestHelpers

  alias PhoenixGon.Pipeline
  alias Plug.Conn

  describe "initialization" do
    test "init" do
      defaults = [namespace: :test, camel_case: true]
      expectation = %{assets: %{}, env: :test, namespace: :test, camel_case: true}
      actual = Pipeline.init(defaults)

      assert actual == expectation
    end
  end

  describe "connection" do
    test "call" do
      conn = Pipeline.call(%Conn{}, Pipeline.init([]))
      actual = conn.private[:phoenix_gon].env
      expectation = Pipeline.init([]).env

      assert actual == expectation
    end
  end
end
