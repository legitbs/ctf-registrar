module ScoreboardHelper
  def challenge_class_for(single_challenge_row)
    return '' if single_challenge_row['created_at'].nil?
    return 'solved'
  end
end
