module ApplicationHelper
  def hacker_count
    (Math::log(User.count) * 4).round + rand(4)
  end

  def teaminfo(team)
    content_tag :div, class: "teaminfo team_#{team.id}" do
      content_tag(:span, team.name, class: 'teamname')
    end
  end

  def body_class
    ["con-#{controller.controller_name}", "act-#{controller.action_name}"].join ' '
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
end
