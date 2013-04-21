class Solution < ActiveRecord::Base
  belongs_to :team
  belongs_to :challenge
  # attr_accessible :title, :body
end
