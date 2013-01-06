module ApplicationHelper
  def teaminfo(team)
    content_tag :div, class: "teaminfo team_#{team.id}" do
      content_tag(:span, team.name, class: 'teamname') +
      content_tag(:span, team.tag, class: 'teamtag')
    end
  end
end
