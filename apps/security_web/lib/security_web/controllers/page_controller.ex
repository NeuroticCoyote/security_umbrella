defmodule SecurityWeb.PageController do
  use SecurityWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
