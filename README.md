# InsertAllReproducer

This is a reproducer for some strange behavior I saw in Ecto/Postgres.

When inserting into temp tables I saw varying performance when using two procedures that should be
equivalent.

This

``` elixir
Repo.insert_all("table", query)
```

should be the same as

``` elixir
{sql, params} = Repo.to_sql(:all, query)
Repo.query("INSERT INTO table #{sql}", params)
```

But I saw the first can get slow after couple of retries (like you do in a performance testing via e.g.
Benchee). So e.g. such query would normally take about 1s, but after a while the performance would
degrade to about 6s. This did not occur when using direct SQL, as shown above. It seems the query
itself gets slow (traced that in Postgres logs), but not sure why, since it's almost the same as
the direct query.

Sadly I wasn't able to reproduce using this app which isolates the behaviour, so far.

## How to run

Start DB with

``` sh
docker run -d -p 5432:5432 -e POSTGRES_HOST_AUTH_METHOD=trust --name insert_all_repro_db postgres
```

Then setup the app with `mix setup`

Then run the app with `iex -S mix phx.server`.

Go to http://localhost:4000/ and follow the instructions.
