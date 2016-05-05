class SolutionHistogram < ActiveRecord::Base
  belongs_to :challenge
  self.table_name = 'solution_histogram'
end
