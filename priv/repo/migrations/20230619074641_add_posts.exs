defmodule Portfolio.Repo.Migrations.AddPosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :body, :text
      add :slug, :string

      timestamps()
    end
  end
end
