defmodule InsertAllReproducer.Repo do
  use Ecto.Repo,
    otp_app: :insert_all_reproducer,
    adapter: Ecto.Adapters.Postgres
end
