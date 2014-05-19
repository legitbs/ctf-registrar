namespace :statdump do
  require 'statdump'

  task :all => %i{ env teams challenges }

  task :teams => [:env, 'tmp/statdump/teams'] do
    c = Team.count
    tn = []
    Team.find_each do |t|
      print "#{t.id} / #{c}"
      tn << [t.id, t.name]
      File.open("tmp/statdump/teams/#{t.id}.html", 'w') do |f|
        f.write Statdump.instance.render 'team', t
      end
      print "\r"
    end
    File.open("tmp/statdump/teams.html", 'w') do |f|
      f.write Statdump.instance.render 'teams', tn
    end
  end

  task :challenges => [:env, 'tmp/statdump/challenges'] do
    Challenge.find_each do |c|
      File.open("tmp/statdump/challenges/#{c.id}.html", 'w') do |f|
        sd = Statdump.instance
        f.write sd.render 'challenge', c
      end
    end
    File.open("tmp/statdump/challenges.html", 'w') do |f|
      f.write Statdump.instance.render 'challenges', Category
    end
  end

  %w{teams challenges}.each do |d|
    directory "tmp/statdump/#{d}" => 'tmp/statdump'
  end
  directory 'tmp/statdump'

  task :env => :environment do
    ActiveRecord::Base.logger.level = Logger::ERROR
    
  end
end
