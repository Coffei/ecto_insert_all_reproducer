defmodule InsertAllReproducerWeb.PageController do
  use InsertAllReproducerWeb, :controller
  alias InsertAllReproducer.Reproducer

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home,
      layout: false,
      sizes: [10, 100, 1000, 10_000, 100_000],
      size: 10_000,
      reps: 1..10,
      rep: 5
    )
  end

  def test(conn, params) do
    size = String.to_integer(params["input"]["size"])
    reps = String.to_integer(params["input"]["reps"])

    ecto_time = Reproducer.time_ecto(size, reps)
    sql_time = Reproducer.time_sql(size, reps)

    render(conn, :home,
      layout: false,
      sizes: [10, 100, 1000, 10_000, 100_000],
      size: size,
      reps: 1..10,
      rep: reps,
      ecto_time: ecto_time,
      sql_time: sql_time
    )
  end
end
