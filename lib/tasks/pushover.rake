namespace :pushover do
  desc 'Update the pushover glance'
  task :glance => :environment do
    Pushover.glance(
      title: 'DC 25 CTF',
      text: "#{Team.count} teams",
      subtext: "#{User.count} players",
      count: Team.count
    )
  end
end
