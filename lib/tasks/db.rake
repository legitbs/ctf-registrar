namespace :db do
  desc 'Dump out all the tweets to a pg custom dump'
  task :dump => 'dump:custom'

  namespace :dump do
    task :custom => :environment do
      output_filename = Rails.root.join 'tmp', "#{Time.now.to_i}-#{Rails.env}.dump"
      dbname = CtfRegistrar::Application.config.database_configuration[Rails.env]['database']
      sh "pg_dump -Fc -f #{output_filename} #{dbname}"
    end

    task :sql => :environment do
      output_filename = Rails.root.join 'tmp', "#{Time.now.to_i}-#{Rails.env}.sql"
      dbname = CtfRegistrar::Application.config.database_configuration[Rails.env]['database']
      sh "pg_dump -Fp -f #{output_filename} #{dbname}"
    end
  end
end
