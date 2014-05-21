namespace :statdump do
  require 'statdump'

  SUBDIRS = %w{teams challenges achievements}

  task :all => %i{ index stylesheet } + SUBDIRS

  task :subdirs => SUBDIRS.map{ |d| "tmp/statdump/#{d}" }

  task :index => [:env, 'tmp/statdump'] do
    File.open("tmp/statdump/index.html", 'w') do |f|
      f.write Statdump.instance.render 'index', nil
    end
  end

  task :stylesheet => [:env, :subdirs] do
    File.open("tmp/statdump/statdump.css", 'w') do |f|
      f.write Statdump.instance.sass_engine.render
    end

    SUBDIRS.each do |sd|
      FileUtils.cp 'tmp/statdump/statdump.css', "tmp/statdump/#{sd}/statdump.css"
    end
  end

  task :teams => :env do
    c = Team.count
    tn = []
    Team.find_each do |t|
      print "Teams: #{t.id} / #{c}"
      tn << [t.id, t.name]
      File.open("tmp/statdump/teams/#{t.id}.html", 'w') do |f|
        f.write Statdump.instance.render 'team', t
      end
      print "\r"
    end

    File.open("tmp/statdump/teams.html", 'w') do |f|
      f.write Statdump.instance.render 'teams', tn
    end

    File.open("tmp/statdump/scoreboard.html", 'w') do |f|
      f.write Statdump.instance.render 'scoreboard', Team.entire_scoreboard
    end
  end

  task :challenges => :env do
    Challenge.find_each do |c|
      File.open("tmp/statdump/challenges/#{c.id}.html", 'w') do |f|
        f.write Statdump.instance.render 'challenge', c
      end
    end
    File.open("tmp/statdump/challenges.html", 'w') do |f|
      f.write Statdump.instance.render 'challenges', Category
    end
  end

  task :achievements => :env do
    Achievement.find_each do |a|
      File.open("tmp/statdump/achievements/#{a.id}.html", 'w') do |f|
        f.write Statdump.instance.render 'achievement', a
      end
    end
    File.open("tmp/statdump/achievements.html", 'w') do |f|
      f.write Statdump.instance.render 'achievements', Achievement
    end
  end

  SUBDIRS.each do |d|
    directory "tmp/statdump/#{d}" => 'tmp/statdump'
  end
  directory 'tmp/statdump'

  task :env => [:environment, :subdirs] do
    ActiveRecord::Base.logger.level = Logger::ERROR
  end
end
