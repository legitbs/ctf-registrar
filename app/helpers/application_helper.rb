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
    accum << ['_setCustomVar', 1, 'Username', request.env['REMOTE_USER']]
    "_gaq.push(#{accum.to_json});"
  end
end
