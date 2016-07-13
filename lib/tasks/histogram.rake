namespace :histogram do

  task :detailed => %i{env} do
    Solution.connection.execute <<-SQL
      DROP TRIGGER IF EXISTS
        solution_histogram_update_trigger
        ON solutions
    SQL

    Solution.connection.execute <<-SQL
      DROP MATERIALIZED VIEW IF EXISTS
        solution_histogram
    SQL

    Solution.connection.execute <<-SQL
      CREATE MATERIALIZED VIEW solution_histogram AS
      SELECT
        challenge_id,
        end_time,
        COUNT(s.id),
        (SELECT
          COUNT(q.id)
          FROM solutions AS q
          WHERE q.challenge_id = s.challenge_id
        ) as tot,
        (100 * COUNT(s.id)/
          (SELECT
            COUNT(id)
            FROM solutions AS q
            WHERE q.challenge_id = s.challenge_id
        ))::float AS pct
      FROM generate_series(
        (select timestamp 'epoch' + 1463788800 * interval '1 second'),
        (select timestamp 'epoch' + 1463961600 * interval '1 second'),
        '1 minute') AS end_time
      RIGHT JOIN
        solutions AS s
        ON s.created_at <= end_time AND s.challenge_id=challenge_id
      GROUP BY end_time, challenge_id
      ORDER BY challenge_id asc, end_time asc
      WITH DATA
      SQL

    Solution.connection.execute <<-SQL
      REFRESH MATERIALIZED VIEW solution_histogram;
    SQL
  end

  task :env => %i{environment} do
    ActiveRecord::Base.logger.level = Logger::ERROR
  end
end
