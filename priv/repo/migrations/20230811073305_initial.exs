defmodule InsertAllReproducer.Repo.Migrations.Initial do
  use Ecto.Migration

  def up do
    create table(:ids, primary_key: false) do
      add :id, :string
    end
  end
end
