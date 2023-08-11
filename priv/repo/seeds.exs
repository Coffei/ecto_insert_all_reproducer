# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     InsertAllReproducer.Repo.insert!(%InsertAllReproducer.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

InsertAllReproducer.Repo.query!(
  "INSERT INTO ids SELECT repeat(id, 5) as id FROM (SELECT gen_random_uuid()::text AS id FROM generate_series(1,1000000)) q"
)
