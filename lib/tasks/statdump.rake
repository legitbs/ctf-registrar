namespace :statdump do
  require 'statdump'

  SUBDIRS = %w{teams challenges images}

  desc 'Package statdump in a bz2ball'
  task :package => :all do
    sh "tar jcf tmp/statdump_2015.tar.bz2 tmp/statdump"
    puts "HEY YO sign it with:"
    puts "gpg -u vito@legitbs.net -b tmp/statdump_2015.tar.bz2"
  end

  desc 'Dump all the public stats'
  task :all => %i{ index stylesheet json } + SUBDIRS

  task :subdirs => SUBDIRS.map{ |d| "tmp/statdump/#{d}" }

  task :index => ['tmp/statdump/index.html', 'tmp/statdump/README.txt']

  file 'tmp/statdump/index.html' => %i(env tmp/statdump) do |t|
    File.open(t.name, 'w') do |f|
      f.write Statdump.instance.render 'index'
    end
  end

  file 'tmp/statdump/README.txt' => 'tmp/statdump' do
    FileUtils.cp 'app/views/statdump/README.txt', 'tmp/statdump/'
  end

  task :stylesheet => ['tmp/statdump/statdump.css', :copy_styles]

  file 'tmp/statdump/statdump.css' => [:env, :subdirs, 'app/assets/stylesheets/statdump.css.sass'] do |t|
    File.open(t.name, 'w') do |f|
      f.write Statdump.instance.sass_engine.render
    end
  end

  task :copy_styles => 'tmp/statdump/statdump.css' do
    SUBDIRS.each do |sd|
      FileUtils.cp 'tmp/statdump/statdump.css', "tmp/statdump/#{sd}/statdump.css"
    end
  end

  task :images => [:env, :subdirs] do
    FileUtils.cp Dir.glob(Rails.root.join "app/assets/images/cheevos/*-64.png"), "tmp/statdump/images/"
  end

  task :json => [:env] do
    File.open("tmp/statdump/teams.json", 'w') do |f|
      f.write Team.all.to_json except: %i{ password_digest prequalified }
    end
    File.open("tmp/statdump/users.json", 'w') do |f|
      f.write User.all.to_json only: %i{ id username team_id created_at }
    end
    File.open("tmp/statdump/challenges.json", 'w') do |f|
      f.write Challenge.all.to_json
    end
    File.open("tmp/statdump/categories.json", 'w') do |f|
      f.write Category.all.to_json except: %i{ updated_at }
    end
    File.open("tmp/statdump/solutions.json", 'w') do |f|
      f.write Solution.all.to_json except: %i{ updated_at }
    end
    # File.open("tmp/statdump/achievements.json", 'w') do |f|
    #   f.write Achievement.all.to_json except: :trophy_id, include: {
    #     trophy: { only: :name }
    #   }
    # end
    # File.open("tmp/statdump/awards.json", 'w') do |f|
    #   f.write Award.all.to_json except: %i{ comment updated_at }
    # end
    File.open("tmp/statdump/notices.json", 'w') do |f|
      f.write Notice.all.to_json except: %i{ updated_at }
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

  # task :achievements => :env do
  #   Achievement.find_each do |a|
  #     next if a.awards.count == 0
  #     File.open("tmp/statdump/achievements/#{a.id}.html", 'w') do |f|
  #       f.write Statdump.instance.render 'achievement', a
  #     end
  #   end
  #   File.open("tmp/statdump/achievements.html", 'w') do |f|
  #     f.write Statdump.instance.render 'achievements', Achievement
  #   end
  # end

  SUBDIRS.each do |d|
    directory "tmp/statdump/#{d}" => 'tmp/statdump'
  end
  directory 'tmp/statdump'

  task :env => [:environment, :subdirs] do
    ActiveRecord::Base.logger.level = Logger::ERROR
  end
end
