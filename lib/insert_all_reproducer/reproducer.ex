defmodule InsertAllReproducer.Reproducer do
  alias InsertAllReproducer.Repo
  import Ecto.Query

  def time_ecto(size, reps) do
    time =
      Enum.map(1..reps, fn _ ->
        {:ok, res} =
          Repo.transaction(fn ->
            create_temp_table()
            query = query(size)
            {time, _} = :timer.tc(fn -> Repo.insert_all("temp", query) end)
            time / 1000
          end)

        res
      end)
      |> Enum.sum()

    time / reps
  end

  def time_sql(size, reps) do
    time =
      Enum.map(1..reps, fn _ ->
        {:ok, res} =
          Repo.transaction(fn ->
            create_temp_table()
            {sql, params} = Repo.to_sql(:all, query(size))
            {time, _} = :timer.tc(fn -> Repo.query!("INSERT INTO temp #{sql}", params) end)
            time / 1000
          end)

        res
      end)
      |> Enum.sum()

    time / reps
  end

  defp create_temp_table do
    Repo.query!("""
    CREATE TEMPORARY TABLE temp (
      id varchar(255) not null
    ) ON COMMIT DROP
    """)
  end

  defp query(size) do
    from(i in "ids", select: %{id: i.id}, limit: ^size, order_by: fragment("RANDOM()"))
  end
end
