module ApplicationHelper
  def hacker_count
    (Math::log(User.count.abs + 1) * 4).round + rand(4)
  end

  def timer_placeholder
    now = Time.now
    seconds = game_window.last - now
    return "Game Over" if seconds <= 0

    minutes = seconds / 60
    hours = minutes / 60

    "%02d:%02d:%02d" % [hours, minutes % 60, seconds % 60]
  end

  MANGLE_LEVELS = %w{clean mangle-1 mangle-2 mangle-3}

  def mangle_class
    actor = rand(4) + 1

    total_seconds = game_window.last - game_window.first
    elapsed_seconds = Time.now - game_window.first
    progress = elapsed_seconds.to_f / total_seconds.to_f

    if (progress < 0) || (progress > 1)
      progress = rand
    end

    bias = progress * MANGLE_LEVELS.length

    index = (rand * bias).to_i

    pick = MANGLE_LEVELS[(rand * bias).to_i]

    "mangle_#{actor}_#{pick}"
  rescue e
    Raygun.track_exception(e) if defined? Raygun
    "mangle_1_clean"
  end

  def teaminfo(team)
    content_tag :div, class: "teaminfo team_#{team.id}" do
      content_tag(:span, team.name, class: 'teamname')
    end
  end

  def body_class
    ["con-#{controller.controller_name}",
     "act-#{controller.action_name}"].join ' '
  end

  REJECT_FLASHES = %i{ analytics cheevo }

  def display_flash
    flash.reject{|k,v| REJECT_FLASHES.include? k }
  end

  def analytics_data
    accum = []
    accum += flash[:analytics] unless flash[:analytics].nil?
    accum += @analytics unless @analytics.nil?
    accum << ['_setCustomVar', 1, 'HTTPAuth', h(request.env['REMOTE_USER'])] if request.env['REMOTE_USER']
    accum << ['_setCustomVar', 2, 'Username', h(current_user.username)] if current_user
    if current_user && (!current_user.team.nil?) && (!current_user.team.name.blank?)
      accum << ['_setCustomVar', 3, 'Team', h(current_user.team.name)]
    end
    accum.map do |i|
      "_gaq.push(#{i.to_json});"
    end.join("\n")
  end

  def cheevos
    return unless flash[:cheevo] && flash[:cheevo].first

    award = Award.find(flash[:cheevo].first)

    image = award.achievement.image
    name = award.achievement.name

    if flash[:cheevo].length > 1
      image = 'multi'
      name = "#{flash[:cheevo].length} different cheevos."
    end

    render(partial: 'shared/cheevo',
           locals: { image: image, name: name })
  rescue
    ''
  end
end
