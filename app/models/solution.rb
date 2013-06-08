class Solution < ActiveRecord::Base
  belongs_to :team
  belongs_to :challenge

  validates :team_id, uniqueness: {scope: :challenge_id}

  attr_accessor :answer
end
