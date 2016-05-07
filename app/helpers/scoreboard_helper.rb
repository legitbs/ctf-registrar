module ScoreboardHelper
  def challenge_class_for(single_challenge_row)
    return 'locked' if single_challenge_row['unlocked_at'].nil?
    return 'solved' unless single_challenge_row['created_at'].nil?
    return 'burning' if single_challenge_row['unlocked_at'] && !single_challenge_row['solved_at']
    return 'live'
  end

  def choice_class_for(single_challenge_row)
    single_challenge_row['class']
  end

  def challenge_id_for(single_challenge_row)
    "#{single_challenge_row['category_name'].parameterize}-#{single_challenge_row['id']}"
  end

  def challenge_li(row, &blk)
    content_tag(:li,
                class: challenge_class_for(row) + ' challenge',
                id: challenge_id_for(row),
                &blk)
  end

end
