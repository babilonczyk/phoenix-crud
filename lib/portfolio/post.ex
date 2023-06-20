defmodule Portfolio.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :body, :string
    field :slug, :string

    timestamps()
  end

  def changeset(post, params \\ %{}) do
    post
    |> cast(params, [:title, :body, :slug])
    |> validate_required([:title, :body])
    |> unique_constraint(:slug)
    |> validate_length(:title, min: 5, max: 100)
    |> validate_length(:body, min: 10, max: 5000)
  end
end
