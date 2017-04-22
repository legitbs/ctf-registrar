class Jarmandy::RootController < Jarmandy::BaseController
  def index
  end

  def matviews
    %w{solution_histogram scored_challenges scoreboard}.each do |mv|
      Solution.connection.execute("REFRESH MATERIALIZED VIEW #{mv};")
    end
    flash[:success] =
      "Refreshed matviews. Weird shit still going down? get vito"
    redirect_to action: 'index'
  end
end
