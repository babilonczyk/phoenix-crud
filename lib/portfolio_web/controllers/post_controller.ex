defmodule PortfolioWeb.PostController do
  use PortfolioWeb, :controller

  alias Portfolio.Post
  alias Portfolio.Repo

  def index(conn, _params) do
    posts = Repo.all(Post)
    render(conn, :index, posts: posts)
  end

  def show(conn, params) do
    post = Repo.get!(Post, params["id"])
    render(conn, :show, post: post)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{}, %{})

    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{ "title" => title  ,"body" => body}) do
    changeset = Post.changeset(%Post{}, %{title: title, body: body})

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: ~p"/posts")
      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def edit(conn, params) do
    post = Repo.get!(Post, params["id"])
    changeset = Post.changeset(post)

    render(conn, :edit, changeset: changeset, post: post)
  end

  def update(conn,  %{"id" => id, "title" => title  ,"body" => body}) do
   changeset =
    Repo.get!(Post, id)
    |> Post.changeset(%{title: title, body: body})

    case Repo.update(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
       |> redirect(to: ~p"/posts")
      {:error, changeset} ->
        render(conn, :edit, changeset: changeset)
    end
  end

  def delete(conn, params) do
    post = Repo.get!(Post, params["id"])
    Repo.delete!(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: ~p"/posts")
  end
end
