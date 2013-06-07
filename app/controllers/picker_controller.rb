class PickerController < ApplicationController
  before_filter :require_hot_team

  def choice
    @categories = Category.for_scoreboard
    @challenges = Challenge.for_scoreboard current_team

    @min_unlock = Challenge.
      where(unlocked_at: nil).
      order('points asc').
      limit(1).
      first.points
    @max_unlock = @min_unlock + 1
    @already = Hash.new

    @challenges.flatten.each do |c|
      next c['class'] = 'solved' if c['created_at']
      next c['class'] = 'live' if c['unlocked_at']
      next c['class'] = 'locked' if c['points'].to_i > @max_unlock
      next c['class'] = 'locked' if @already[c['category_name']]
      @already[c['category_name']] = true
      c['class'] = 'burning'
    end
  end
end
