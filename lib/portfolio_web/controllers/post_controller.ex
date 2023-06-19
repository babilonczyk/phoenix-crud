defmodule PortfolioWeb.PostController do
  use PortfolioWeb, :controller

  def new(conn, _params) do
    render(conn, :new, layout: false)
  end
end
