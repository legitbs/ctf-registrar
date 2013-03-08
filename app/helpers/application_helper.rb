module ApplicationHelper
  def teaminfo(team)
    content_tag :div, class: "teaminfo team_#{team.id}" do
      content_tag(:span, team.name, class: 'teamname')
    end
  end

  def analytics_data
    accum = []
    accum += flash[:analytics] unless flash[:analytics].nil?
    accum += @analytics unless @analytics.nil?
    accum << ['_setCustomVar', 1, 'HTTPAuth', request.env['REMOTE_USER']] if request.env['REMOTE_USER']
    accum << ['_setCustomVar', 2, 'Username', current_user.username] if current_user
    accum << ['_setCustomVar', 3, 'Team', current_user.team.name] if current_user.try(:team)
    "_gaq.push(#{accum.to_json});"
  end
end
