class Observation < ActiveRecord::Base
  belongs_to :team
  belongs_to :challenge
  belongs_to :user
end
