module ApplicationHelper
  def teaminfo(team)
    content_tag :div, class: "teaminfo team_#{team.id}" do
      content_tag(:span, team.name, class: 'teamname')
    end
  end
end
