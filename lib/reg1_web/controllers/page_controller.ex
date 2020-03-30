defmodule Reg1Web.PageController do
  use Reg1Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
