namespace :pushover do
  desc 'Update the pushover glance'
  task :glance => :environment do
    unsolved_challs_count = Challenge.where(solved_at: nil).count
    total_challs_count = Challenge.count

    percent_solved = 1.0 - (unsolved_challs_count.to_f / total_challs_count)

    leading_team_name = Team.entire_scoreboard.first["team_name"]

    Pushover.glance(
      title: 'DC 25 CTF',
      text: "#{Team.count} teams",
      subtext: "#{leading_team_name} leads",
      count: unsolved_challs_count,
      percent: (percent_solved * 100).to_i
    )
  end
end
