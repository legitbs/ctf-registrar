class ScoredChallenge < ActiveRecord::Base
  self.primary_key = 'id'

  def points
    calc_points.round
  end
end
